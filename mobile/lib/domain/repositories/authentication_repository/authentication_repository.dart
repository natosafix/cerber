import 'package:dio/dio.dart';

import '../../../utils/result.dart';
import 'requests/log_in_request.dart';
import 'requests/sign_up_request.dart';
import 'responses/authentication_response.dart';

abstract class AuthenticationRepository {
  Future<Result<AuthenticationResponse, DioException>> logIn(LogInRequest logInRequest);

  Future<Result<AuthenticationResponse, DioException>> signUp(SignUpRequest signUpRequest);
}
