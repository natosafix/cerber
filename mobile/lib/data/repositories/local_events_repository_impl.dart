import '../../domain/models/event.dart';
import '../../domain/models/visitor.dart';
import '../../domain/repositories/events_repository/requests/get_visitors_request.dart';
import '../../domain/repositories/local_events_repository/local_event_repository.dart';
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
  Future<Result<List<Event>, Exception>> getEvents(int limit, int offset) async {
    final events = await _eventsDatabase.getEvents(limit, offset);
    return Success(events.map(EventCollection.toModel).toList());
  }

  @override
  Future<Result<List<Visitor>, Exception>> getVisitors(GetVisitorsRequest request) async {
    final visitors = await _eventsDatabase.getVisitors(
      request.eventId,
      request.limit,
      request.offset,
    );

    return Success(visitors.map(VisitorCollection.toModel).toList());
  }

  @override
  void saveEvents(List<Event> events) async {
    _eventsDatabase.addEvents(events.map(EventCollection.fromModel).toList());
  }

  @override
  void saveVisitors(List<Visitor> visitors, String eventId) async {
    _eventsDatabase.addVisitors(visitors.map((e) => VisitorCollection.fromModel(e, eventId)).toList());
  }
}
