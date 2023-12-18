import 'package:isar/isar.dart';
import 'package:project/data/datasources/local/events_database/collections/event_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/visitor_collection.dart';

class EventsDatabase {
  EventsDatabase({required Isar isar}) : _isar = isar;

  final Isar _isar;

  IsarCollection<EventCollection> get _events => _isar.collection<EventCollection>();
  IsarCollection<VisitorCollection> get _visitors => _isar.collection<VisitorCollection>();

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

  Future<List<VisitorCollection>> getVisitors({
    required int eventId,
    required int limit,
    required int offset,
  }) async {
    return await _visitors.where().eventIdEqualTo(eventId).offset(offset).limit(limit).findAll();
  }

  Future<void> addVisitors(List<VisitorCollection> visitors) async {
    await _isar.writeTxn(() async {
      await _visitors.putAll(visitors);
    });
  }
}
