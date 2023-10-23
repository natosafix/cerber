import 'package:dio/dio.dart';

import '../../utils/result.dart';
import '../models/requests/log_in_request.dart';
import '../models/requests/sign_up_request.dart';
import '../models/responses/authentication_response.dart';

abstract class AuthenticationRepository {
  Future<Result<AuthenticationResponse, DioException>> logIn(LoginRequest logInRequest);

  Future<Result<AuthenticationResponse, DioException>> signUp(SignUpRequest signUpRequest);
}
