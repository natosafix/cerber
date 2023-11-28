import 'package:isar/isar.dart';

import 'collections/event_collection.dart';
import 'collections/visitor_collection.dart';

class DatabaseAdapter {
  DatabaseAdapter({required Isar isar}) : _isar = isar;

  final Isar _isar;

  IsarCollection<EventCollection> get _events => _isar.collection<EventCollection>();
  IsarCollection<VisitorCollection> get _visitors => _isar.collection<VisitorCollection>();

  Future<List<EventCollection>> getEvents(int limit, int offset) async {
    return await _events.where().offset(offset).limit(limit).findAll();
  }

  Future<EventCollection?> getEventById(String id) async {
    return await _events.where().eventIdEqualTo(id).findFirst();
  }

  Future<void> addEvents(List<EventCollection> events) async {
    await _isar.writeTxn(() async {
      await _events.putAll(events);
    });
  }

  Future<void> deleteEvent(EventCollection event) async {
    await _isar.writeTxn(() async {
      await _events.delete(event.isarId);
    });
  }

  Future<List<VisitorCollection>> getVisitors(String eventId, int limit, int offset) async {
    return await _visitors.where().eventIdEqualTo(eventId).offset(offset).limit(limit).findAll();
  }

  Future<void> addVisitors(List<VisitorCollection> visitors) async {
    await _isar.writeTxn(() async {
      await _visitors.putAll(visitors);
    });
  }
}
