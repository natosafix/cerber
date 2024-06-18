import 'package:dio/dio.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_repository.dart';
import 'package:project/utils/locator.dart';
import 'package:project/utils/result.dart';

class LogInUsecase {
  final _authenticationRepository = locator<AuthenticationRepository>();

  Future<Result<Nothing, DioException>> call({
    required String email,
    required String password,
  }) async {
    return await _authenticationRepository.logIn(
      email: email,
      password: password,
    );
  }
}
