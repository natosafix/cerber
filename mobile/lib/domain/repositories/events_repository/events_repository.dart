import '../../../utils/result.dart';
import '../../models/event.dart';
import '../../models/visitor.dart';
import 'requests/get_visitors_request.dart';

abstract class EventsRepository {
  Future<Result<List<Event>, Exception>> getEvents(int limit, int offset);

  Future<Result<List<Visitor>, Exception>> getVisitors(GetVisitorsRequest getVisitorsRequest);
}
