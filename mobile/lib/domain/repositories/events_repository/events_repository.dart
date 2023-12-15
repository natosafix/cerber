import '../../../utils/result.dart';
import '../../models/event.dart';
import '../../models/visitor.dart';

abstract class EventsRepository {
  Future<Result<List<Event>, Exception>> getEvents({
    required int offset,
    required int limit,
  });

  Future<Result<List<Visitor>, Exception>> getVisitors({
    required String eventId,
    required int limit,
    required int offset,
  });
}
