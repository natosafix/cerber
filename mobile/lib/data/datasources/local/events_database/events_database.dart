import 'package:isar/isar.dart';
import 'package:project/data/datasources/local/events_database/collections/answer_collection/answer_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/event_collection/event_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/question_collection/question_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/visitor_collection/visitor_collection.dart';

class EventsDatabase {
  EventsDatabase({required Isar isar}) : _isar = isar;

  final Isar _isar;

  IsarCollection<EventCollection> get _events => _isar.collection();
  IsarCollection<VisitorCollection> get _visitors => _isar.collection();
  IsarCollection<AnswerCollection> get _answers => _isar.collection();
  IsarCollection<QuestionCollection> get _questions => _isar.collection();

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
    await _isar.writeTxn(() async {
      await _events.putAll(events);
    });
  }

  Future<void> deleteEventsByIds(List<int> eventsIds) async {
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

  Future<void> addAnswers(List<AnswerCollection> answers) async {
    final questions = answers.map((e) => e.question.value!).toList();
    _isar.writeTxnSync(() {
      _questions.putAllSync(questions);
      _answers.putAllSync(answers);
    });
  }

  Future<List<AnswerCollection?>> findAnswers(List<Id> answersIds) async {
    return await _answers.getAll(answersIds);
  }

  Future<VisitorCollection?> findVisitor(String visitorId, Id eventId) async {
    return await _visitors.getByVisitorIdEventId(visitorId, eventId);
  }
}
