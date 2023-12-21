import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/utils/result.dart';

abstract class EventsRepository {
  Future<Result<List<Event>, Exception>> getEvents({
    required int offset,
    required int limit,
  });

  Future<Visitor?> findVisitor(String visitorId, int eventId);
}
