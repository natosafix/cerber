import 'package:dio/dio.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/events_repository.dart';
import 'package:project/utils/result.dart';

abstract class RemoteEventsRepository implements EventsRepository {
  Future<Result<List<Visitor>, DioException>> downloadVisitors(int eventId);
}
