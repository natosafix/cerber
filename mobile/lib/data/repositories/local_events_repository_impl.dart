import '../../domain/models/event.dart';
import '../../domain/models/visitor.dart';
import '../../domain/repositories/local_events_repository/local_events_repository.dart';
import '../../utils/result.dart';
import '../datasources/local/events_database/collections/event_collection.dart';
import '../datasources/local/events_database/collections/visitor_collection.dart';
import '../datasources/local/events_database/events_database.dart';

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
  Future<Result<List<Visitor>, Exception>> getVisitors({
    required int eventId,
    required int limit,
    required int offset,
  }) async {
    final visitors = await _eventsDatabase.getVisitors(
      eventId: eventId,
      limit: limit,
      offset: offset,
    );

    return Success(visitors.map(VisitorCollection.toModel).toList());
  }

  @override
  void saveEvents(List<Event> events) async {
    _eventsDatabase.addEvents(events.map(EventCollection.fromModel).toList());
  }

  @override
  void saveVisitors(List<Visitor> visitors, int eventId) async {
    _eventsDatabase.addVisitors(visitors.map((e) => VisitorCollection.fromModel(e, eventId)).toList());
  }

  @override
  void deleteEventsByIds(List<int> ids) {
    _eventsDatabase.deleteEventsByIds(ids);
  }

  @override
  Future<List<int>> getAllEventsIds() async {
    return await _eventsDatabase.getAllEventsIds();
  }
}
