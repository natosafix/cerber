import 'package:dio/dio.dart';

import '../../utils/result.dart';
import '../models/models/event.dart';

abstract class EventsRemoteRepository {
  Future<Result<List<Event>, DioException>> getEvents(int limit, int offset);
}
