import 'package:dio/dio.dart';

import '../../domain/models/models/event.dart';
import '../../domain/repositories/events_remote_repository.dart';
import '../../utils/result.dart';

class MockEventsRepo implements EventsRemoteRepository {
  @override
  Future<Result<List<Event>, DioException>> getEvents(int limit, int offset) async {
    await Future.delayed(const Duration(seconds: 1));

    final events = Event.mock.skip(offset).take(limit).toList();

    return Success(events);
  }
}
