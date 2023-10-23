import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'authentication_service.g.dart';

@RestApi()
abstract class AuthenticationService {
  factory AuthenticationService(Dio dio, {String baseUrl}) = _AuthenticationService;

  // @GET('/tasks')
  // Future<List<String>> getTasks();
}