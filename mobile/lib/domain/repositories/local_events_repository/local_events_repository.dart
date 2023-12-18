import '../../models/event.dart';
import '../../models/visitor.dart';
import '../events_repository/events_repository.dart';

abstract class LocalEventsRepository implements EventsRepository {
  void saveEvents(List<Event> events);

  void saveVisitors(List<Visitor> visitors, int eventId);

  void deleteEventsByIds(List<int> ids);

  Future<List<int>> getAllEventsIds();
}
