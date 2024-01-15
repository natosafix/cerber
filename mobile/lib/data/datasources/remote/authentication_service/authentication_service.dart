import 'package:dio/dio.dart';
import 'package:project/data/datasources/remote/authentication_service/requests/log_in_request.dart';
import 'package:project/data/datasources/remote/authentication_service/requests/register_request.dart';
import 'package:project/data/datasources/remote/authentication_service/responses/log_in_response.dart';
import 'package:retrofit/retrofit.dart';

part 'authentication_service.g.dart';

@RestApi()
abstract class AuthenticationService {
  factory AuthenticationService(Dio dio, {String baseUrl}) = _AuthenticationService;

  @POST('/login')
  Future<LogInResponse> login(@Body() LogInRequest logInRequest);

  @POST('/register')
  Future<void> register(@Body() RegisterRequest registerRequest);
}
