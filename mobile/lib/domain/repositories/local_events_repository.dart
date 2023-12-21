import '../models/event.dart';
import '../models/visitor.dart';
import 'events_repository.dart';

abstract class LocalEventsRepository implements EventsRepository {
  Future<void> saveEvents(List<Event> events);

  Future<void> saveVisitors(List<Visitor> visitors, int eventId);

  Future<void> deleteEventsByIds(List<int> ids);

  Future<List<int>> getAllEventsIds();

  Future<void> deleteVisitors(int eventId);

  Stream<Event> watchEvent(int eventId);

  Future<void> deleteAllData();
}
