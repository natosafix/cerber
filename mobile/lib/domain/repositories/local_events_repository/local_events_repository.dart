import '../../models/event.dart';
import '../../models/visitor.dart';
import '../events_repository/events_repository.dart';

abstract class LocalEventsRepository implements EventsRepository {
  void saveEvents(List<Event> events);

  void saveVisitors(List<Visitor> visitors, String eventId);

  void deleteEventsByIds(List<String> ids);

  Future<List<String>> getAllEventsIds();
}
