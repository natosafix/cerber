import 'package:dio/dio.dart';

import '../../../utils/result.dart';
import '../../models/event.dart';
import '../../models/visitor.dart';
import 'requests/get_visitors_request.dart';

abstract class EventsRemoteRepository {
  Future<Result<List<Event>, DioException>> getEvents(int limit, int offset);

  Future<Result<List<Visitor>, DioException>> getVisitors(GetVisitorsRequest getVisitorsRequest);
}
