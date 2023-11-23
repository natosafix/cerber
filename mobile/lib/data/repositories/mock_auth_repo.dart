import 'package:dio/dio.dart';

import '../../domain/repositories/authentication_repository/authentication_repository.dart';
import '../../domain/repositories/authentication_repository/requests/log_in_request.dart';
import '../../domain/repositories/authentication_repository/requests/sign_up_request.dart';
import '../../domain/repositories/authentication_repository/responses/authentication_response.dart';
import '../../utils/result.dart';

class MockAuthRepo implements AuthenticationRepository {
  @override
  Future<Result<AuthenticationResponse, DioException>> logIn(LogInRequest logInRequest) async {
    await Future.delayed(const Duration(seconds: 1));

    return Success(AuthenticationResponse(token: "LogInToken"));
  }

  @override
  Future<Result<AuthenticationResponse, DioException>> signUp(SignUpRequest signUpRequest) async {
    await Future.delayed(const Duration(seconds: 1));

    return Success(AuthenticationResponse(token: "SignUpToken"));
  }
}