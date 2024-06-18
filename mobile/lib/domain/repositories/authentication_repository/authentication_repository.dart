import 'package:dio/dio.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_status.dart';
import 'package:project/utils/result.dart';

abstract class AuthenticationRepository {
  Stream<AuthenticationStatus> get authenticationStatus;

  Future<Result<Nothing, DioException>> logIn({
    required String email,
    required String password,
  });

  Future<Result<Nothing, DioException>> signUp({
    required String email,
    required String username,
    required String password,
  });

  void logOut();

  void checkAuthenticationStatus();

  Future<bool> tryRefreshToken();
}
