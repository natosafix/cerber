import 'package:dio/dio.dart';
import 'package:project/data/datasources/remote/events_service/events_service.dart';
import 'package:project/data/datasources/remote/events_service/mappers/event_mapper.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/events_repository/events_repository.dart';
import 'package:project/utils/result.dart';

class RemoteEventsRepositoryImpl implements EventsRepository {
  RemoteEventsRepositoryImpl({
    required EventsService eventsService,
  }) : _eventsService = eventsService;

  final EventsService _eventsService;

  @override
  Future<Result<List<Event>, Exception>> getEvents({
    required int offset,
    required int limit,
  }) async {
    try {
      final response = await _eventsService.getEvents(offset, limit);
      final events = response.map((e) => e.toModel()).toList();
      return Success(events);
    } on DioException catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<List<Visitor>, Exception>> getVisitors({
    required String eventId,
    required int limit,
    required int offset,
  }) async {
    // TODO: implement getVisitors
    throw UnimplementedError();
  }
}
