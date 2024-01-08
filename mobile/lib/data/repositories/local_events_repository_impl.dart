import 'dart:async';

import 'package:project/data/datasources/local/events_database/collections/answer_collection/answer_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/event_collection/event_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/question_collection/question_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/visitor_collection/visitor_collection.dart';
import 'package:project/data/datasources/local/events_database/events_database.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_repository.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_status.dart';
import 'package:project/domain/repositories/local_events_repository.dart';
import 'package:project/utils/locator.dart';
import 'package:project/utils/result.dart';

class LocalEventsRepositoryImpl implements LocalEventsRepository {
  LocalEventsRepositoryImpl({
    required EventsDatabase eventsDatabase,
  }) : _eventsDatabase = eventsDatabase {
    locator<AuthenticationRepository>().authenticationStatus.listen((status) {
      if (status == AuthenticationStatus.unauthenticated) {
        deleteAllData();
      }
    });
  }

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

    final answersCollections = await _eventsDatabase.findAnswers(visitor.answersIds);

    final questionsMap = {
      for (final answer in answersCollections)
        QuestionCollection.toModel(answer!.getQuestion()): AnswerCollection.toModel(answer)
    };

    return VisitorCollection.toModel(visitor, questionsMap);
  }

  @override
  Future<void> saveEvents(List<Event> events) async {
    await _eventsDatabase.addEvents(events.map(EventCollection.fromModel).toList());
  }

  @override
  Future<void> saveVisitors(List<Visitor> visitors, int eventId) async {
    final answers = visitors
        .map((e) => e.questionsMap)
        .expand((e) => e.entries)
        .map(
          (e) => AnswerCollection.fromModel(e.value, e.key, eventId),
        )
        .toList();
    await _eventsDatabase.addAnswers(answers);

    final visitorsCollections = visitors.map((e) => VisitorCollection.fromModel(e, eventId)).toList();
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
}
