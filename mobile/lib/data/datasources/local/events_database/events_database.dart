import 'dart:async';

import 'package:isar/isar.dart';
import 'package:project/data/datasources/local/events_database/collections/answer_collection/answer_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/event_collection/event_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/question_collection/question_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/ticket_collection/ticket_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/visitor_collection/visitor_collection.dart';

class EventsDatabase {
  EventsDatabase({required Isar isar}) : _isar = isar;

  final Isar _isar;

  IsarCollection<EventCollection> get _events => _isar.collection();
  IsarCollection<VisitorCollection> get _visitors => _isar.collection();
  IsarCollection<AnswerCollection> get _answers => _isar.collection();
  IsarCollection<QuestionCollection> get _questions => _isar.collection();
  IsarCollection<TicketCollection> get _tickets => _isar.collection();

  Future<void> deleteAllData() async {
    await _isar.writeTxn(() async {
      await Future.wait([
        _events.clear(),
        _answers.clear(),
        _visitors.clear(),
        _questions.clear(),
        _tickets.clear(),
      ]);
    });
  }

  Future<List<EventCollection>> getEvents({
    required int limit,
    required int offset,
  }) async {
    return await _events.where().offset(offset).limit(limit).findAll();
  }

  Future<List<int>> getAllEventsIds() async {
    return await _events.where().idProperty().findAll();
  }

  Future<void> addEvents(List<EventCollection> events) async {
    for (final event in events) {
      final saved = await _events.get(event.id);
      if (saved == null) continue;
      event.lastDownloaded = saved.lastDownloaded;
    }
    await _isar.writeTxn(() async {
      await _events.putAll(events);
    });
  }

  Stream<EventCollection> watchEvent(Id eventId) async* {
    yield* _events.watchObject(eventId, fireImmediately: true).map((event) {
      return event!;
    });
  }

  Future<void> deleteEventsByIds(List<Id> eventsIds) async {
    await _isar.writeTxn(() async {
      await _events.deleteAll(eventsIds);
    });
  }

  Future<void> updateLastDownloaded(Id eventId) async {
    final now = DateTime.now();
    await _isar.writeTxn(() async {
      final event = await _events.get(eventId);
      event!.lastDownloaded = now;
      await _events.put(event);
    });
  }

  Future<void> addAnswers(List<AnswerCollection> answers) async {
    await _isar.writeTxn(() async {
      _answers.putAll(answers);
    });
  }

  Future<List<AnswerCollection?>> findAnswers(List<Id> answersIds) async {
    return await _answers.getAll(answersIds);
  }

  Future<void> addVisitors(List<VisitorCollection> visitors) async {
    await _isar.writeTxn(() async {
      await _visitors.putAll(visitors);
    });
  }

  Future<void> deleteVisitors(Id eventId) async {
    await _isar.writeTxn(() async {
      await _visitors.where().eventIdEqualTo(eventId).deleteAll();
    });
  }

  Future<VisitorCollection?> findVisitor(String visitorId, Id eventId) async {
    return await _visitors.getByVisitorIdEventId(visitorId, eventId);
  }

  Future<void> setVisitorsQrCodeScanned(String visitorId, Id eventId) async {
    final now = DateTime.now();
    await _isar.writeTxn(() async {
      final visitor = await _visitors.getByVisitorIdEventId(visitorId, eventId);
      if (visitor == null) return;

      visitor.qrCodeScannedTime = now;

      await _visitors.put(visitor);
    });
  }

  Future<List<VisitorCollection>> getGeneratedVisitors(Id eventId) async {
    return await _visitors
        .where()
        .eventIdEqualTo(eventId)
        .filter()
        .isGeneratedEqualTo(true)
        .findAll();
  }

  Stream<int> generatedVisitorsCountStream(Id eventId) async* {
    final query = _visitors.where().eventIdEqualTo(eventId).filter().isGeneratedEqualTo(true);

    yield* query.watch(fireImmediately: true).map((visitors) {
      return visitors.length;
    });
  }

  Future<void> setVisitorSynced(String oldId, String newId, Id eventId) async {
    await _isar.writeTxn(() async {
      final old = await findVisitor(oldId, eventId);
      if (old == null) {
        return;
      }

      final newVisitor = VisitorCollection(
        visitorId: old.visitorId,
        eventId: old.eventId,
        answersIds: old.answersIds,
        ticketId: old.ticketId,
        qrCodeScannedTime: old.qrCodeScannedTime,
        isGenerated: null,
      );

      await _visitors.delete(old.isarId);
      await _visitors.put(newVisitor);
    });
  }

  Future<List<QuestionCollection>> getQuestions(Id eventId) async {
    return await _questions.where().eventIdEqualTo(eventId).findAll();
  }

  Future<void> addQuestions(List<QuestionCollection> questions) async {
    await _isar.writeTxn(() async {
      _questions.putAll(questions);
    });
  }

  Future<void> deleteQuestions(Id eventId) async {
    await _isar.writeTxn(() async {
      await _questions.where().eventIdEqualTo(eventId).deleteAll();
    });
  }

  Future<List<TicketCollection>> getTickets(Id eventId) async {
    return await _tickets.where().eventIdEqualTo(eventId).findAll();
  }

  Future<TicketCollection?> getTicket(Id ticketId) async {
    return await _tickets.get(ticketId);
  }

  Future<void> addTickets(List<TicketCollection> tickets) async {
    await _isar.writeTxn(() async {
      await _tickets.putAll(tickets);
    });
  }

  Future<void> deleteTickets(Id eventId) async {
    await _isar.writeTxn(() async {
      await _tickets.where().eventIdEqualTo(eventId).deleteAll();
    });
  }
}
