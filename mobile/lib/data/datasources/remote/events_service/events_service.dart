import 'package:dio/dio.dart';
import 'package:project/data/datasources/remote/events_service/responses/event_api_response.dart';
import 'package:project/data/datasources/remote/events_service/responses/question_api_response.dart';
import 'package:project/data/datasources/remote/events_service/responses/visitor_api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'events_service.g.dart';

@RestApi()
abstract class EventsService {
  factory EventsService(Dio dio, {String baseUrl}) = _EventsService;

  @GET('/events/inspected')
  Future<List<EventApiResponse>> getEvents(
    @Query('offset') int offset,
    @Query('limit') int limit,
  );

  @GET('/orders')
  Future<List<VisitorApiResponse>> getVisitors(
    @Query('eventId') int eventId,
  );

  @GET('/questions')
  Future<List<QuestionApiResponse>> getQuestions(
    @Query('eventId') int eventId,
  );
}
