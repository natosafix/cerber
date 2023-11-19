import 'package:dio/dio.dart';

import '../../domain/models/event.dart';
import '../../domain/models/visitor.dart';
import '../../domain/repositories/events_remote_repository/events_remote_repository.dart';
import '../../domain/repositories/events_remote_repository/requests/get_visitors_request.dart';
import '../../utils/result.dart';

class MockEventsRepo implements EventsRemoteRepository {
  @override
  Future<Result<List<Event>, DioException>> getEvents(int limit, int offset) async {
    await Future.delayed(const Duration(seconds: 1));

    final events = Event.mock.skip(offset).take(limit).toList();

    return Success(events);
  }

  @override
  Future<Result<List<Visitor>, DioException>> getVisitors(GetVisitorsRequest getVisitorsRequest) async {
    await Future.delayed(const Duration(seconds: 1));

    final visitors = Visitor.mock.skip(getVisitorsRequest.offset).take(getVisitorsRequest.limit).toList();

    return Success(visitors);
  }
}
