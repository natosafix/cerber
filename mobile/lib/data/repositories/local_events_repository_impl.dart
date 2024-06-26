import 'dart:async';

import 'package:project/data/datasources/local/events_database/collections/answer_collection/answer_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/event_collection/event_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/question_collection/question_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/ticket_collection/ticket_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/visitor_collection/visitor_collection.dart';
import 'package:project/data/datasources/local/events_database/events_database.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/filled_answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/new_visitor_id.dart';
import 'package:project/domain/models/ticket.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/local_events_repository.dart';
import 'package:project/utils/result.dart';

class LocalEventsRepositoryImpl implements LocalEventsRepository {
  LocalEventsRepositoryImpl({
    required EventsDatabase eventsDatabase,
  }) : _eventsDatabase = eventsDatabase;

  final EventsDatabase _eventsDatabase;

  @override
  Future<Result<List<Event>, Exception>> getEvents({
    required int offset,
    required int limit,
  }) async {
    final events = await _eventsDatabase.getEvents(
      limit: limit,
      offset: offset,
    );

    return Success(events.map(EventCollection.toModel).toList());
  }

  @override
  Future<Visitor?> findVisitor(String visitorId, int eventId) async {
    final visitor = await _eventsDatabase.findVisitor(visitorId, eventId);
    if (visitor == null) return null;

    final answers = await _eventsDatabase.findAnswers(visitor.answersIds);
    final questions = await _eventsDatabase.getQuestions(eventId);

    final questionsMap = {
      for (final answer in answers)
        QuestionCollection.toModel(questions.firstWhere((q) => q.id == answer!.questionId)):
            AnswerCollection.toModel(answer!)
    };

    final ticket = await _eventsDatabase.getTicket(visitor.ticketId);

    return VisitorCollection.toModel(visitor, ticket!, questionsMap);
  }

  @override
  Future<void> saveEvents(List<Event> events) async {
    await _eventsDatabase.addEvents(events.map(EventCollection.fromModel).toList());
  }

  @override
  Future<void> saveVisitors(List<Visitor> visitors, int eventId) async {
    final answers = visitors
        .map((visitor) => visitor.questionsMap.values)
        .expand((e) => e)
        .map(
          (answer) => AnswerCollection.fromModel(answer),
        )
        .toList();
    await _eventsDatabase.addAnswers(answers);

    final visitorsCollections =
        visitors.map((e) => VisitorCollection.fromModel(e, eventId)).toList();
    await _eventsDatabase.addVisitors(visitorsCollections);

    await _eventsDatabase.updateLastDownloaded(eventId);
  }

  @override
  Future<void> deleteEventsByIds(List<int> ids) async {
    await _eventsDatabase.deleteEventsByIds(ids);
  }

  @override
  Future<List<int>> getAllEventsIds() async {
    return await _eventsDatabase.getAllEventsIds();
  }

  @override
  Future<void> deleteVisitors(int eventId) async {
    await _eventsDatabase.deleteVisitors(eventId);
  }

  @override
  Stream<Event> watchEvent(int eventId) async* {
    yield* _eventsDatabase.watchEvent(eventId).map((event) {
      return EventCollection.toModel(event);
    });
  }

  @override
  Future<void> deleteAllData() async {
    await _eventsDatabase.deleteAllData();
  }

  @override
  Future<Result<List<Question>, Exception>> getQuestions(int eventId) async {
    final questions = await _eventsDatabase.getQuestions(eventId);
    return Success(questions.map((e) => QuestionCollection.toModel(e)).toList());
  }

  @override
  Future<void> saveQuestions(List<Question> questions, int eventId) async {
    final questionsCollections =
        questions.map((e) => QuestionCollection.fromModel(e, eventId)).toList();
    await _eventsDatabase.addQuestions(questionsCollections);
  }

  @override
  Future<void> deleteQuestions(int eventId) async {
    await _eventsDatabase.deleteQuestions(eventId);
  }

  @override
  Future<void> setVisitorQrCodeScanned(String visitorId, int eventId) async {
    await _eventsDatabase.setVisitorsQrCodeScanned(visitorId, eventId);
  }

  @override
  Future<List<Ticket>?> getTickets(int eventId) async {
    final tickets = await _eventsDatabase.getTickets(eventId);
    return tickets.map(TicketCollection.toModel).toList();
  }

  @override
  Future<void> saveTickets(List<Ticket> tickets, int eventId) async {
    final ticketsCollections = tickets.map((e) => TicketCollection.fromModel(e, eventId)).toList();
    await _eventsDatabase.addTickets(ticketsCollections);
  }

  @override
  Future<void> deleteTickets(int eventId) async {
    await _eventsDatabase.deleteTickets(eventId);
  }

  @override
  Future<NewVisitorId?> addNewVisitorAnswers(
    int ticketId,
    List<FilledAnswer> filledAnswers,
    int eventId,
  ) async {
    final answers = [
      for (final filledAnswer in filledAnswers)
        AnswerCollection.autoId(
          answers: filledAnswer.answers,
          questionId: filledAnswer.questionId,
        ),
    ];

    await _eventsDatabase.addAnswers(answers);

    final visitor = VisitorCollection.autoId(
      eventId: eventId,
      answersIds: answers.map((e) => e.id).toList(),
      ticketId: ticketId,
      qrCodeScannedTime: DateTime.now(),
      isGenerated: true,
    );
    await _eventsDatabase.addVisitors([visitor]);

    return NewVisitorId(visitor.visitorId);
  }

  @override
  Future<List<Visitor>> getGeneratedVisitors(int eventId) async {
    final List<VisitorCollection> visitors = await _eventsDatabase.getGeneratedVisitors(eventId);

    final result = <Visitor>[];

    for (final visitorCollection in visitors) {
      final Visitor? model = await findVisitor(visitorCollection.visitorId, eventId);
      result.add(model!);
    }

    return result;
  }

  @override
  Future<void> setVisitorSynced(String oldId, String newId, int eventId) async {
    await _eventsDatabase.setVisitorSynced(oldId, newId, eventId);
  }

  @override
  Stream<int> watchGeneratedVisitorsCount(int eventId) async* {
    yield* _eventsDatabase.generatedVisitorsCountStream(eventId);
  }
}
