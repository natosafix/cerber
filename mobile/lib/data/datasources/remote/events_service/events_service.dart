import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'events_service.g.dart';

@RestApi()
abstract class EventsService {
  factory EventsService(Dio dio, {String baseUrl}) = _EventsService;

  // @GET('/tasks')
  // Future<List<String>> getTasks();
}
