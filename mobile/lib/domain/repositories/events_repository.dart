import '../../utils/result.dart';
import '../models/event.dart';
import '../models/visitor.dart';

abstract class EventsRepository {
  Future<Result<List<Event>, Exception>> getEvents({
    required int offset,
    required int limit,
  });

  Future<Visitor?> findVisitor(String visitorId, int eventId);
}
