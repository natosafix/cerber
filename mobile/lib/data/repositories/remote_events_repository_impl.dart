import 'package:dio/dio.dart';
import 'package:project/data/datasources/remote/events_service/events_service.dart';
import 'package:project/data/datasources/remote/events_service/mappers/event_mapper.dart';
import 'package:project/data/datasources/remote/events_service/mappers/question_mapper.dart';
import 'package:project/data/datasources/remote/events_service/mappers/visitor_mapper.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/remote_events_repository.dart';
import 'package:project/utils/result.dart';

class RemoteEventsRepositoryImpl implements RemoteEventsRepository {
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
  Future<Visitor?> findVisitor(String visitorId, int eventId) {
    // TODO: implement findVisitor
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Visitor>, DioException>> downloadVisitors(int eventId) async {
    try {
      final questionsResponse = await _eventsService.getQuestions(eventId);
      final visitorsResponse = await _eventsService.getVisitors(eventId);
      
      final questions = questionsResponse.map((e) => e.toModel());
      final questionsMap = {for (final question in questions) question.id: question};

      Question questionGetter(int questionId) => questionsMap[questionId]!;

      final visitors = visitorsResponse.map((e) => e.toModel(questionGetter)).toList();

      return Success(visitors);
    } on DioException catch (e) {
      return Failure(e);
    }
  }
}