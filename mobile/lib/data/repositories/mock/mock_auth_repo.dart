import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_repository.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_status.dart';
import 'package:project/utils/constants/secure_storage_keys.dart';
import 'package:project/utils/locator.dart';
import 'package:project/utils/result.dart';

class MockAuthRepo implements AuthenticationRepository {
  final _secureStorage = locator<FlutterSecureStorage>();

  final _authenticationController = StreamController<AuthenticationStatus>.broadcast();

  @override
  Stream<AuthenticationStatus> get authenticationStatus async* {
    yield* _authenticationController.stream;
  }

  @override
  Future<Result<Nothing, DioException>> logIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 3));

    await _secureStorage.write(key: SecureStorageKeys.authToken, value: "TEST_TOKEN");

    _authenticationController.add(AuthenticationStatus.authenticated);

    return const Success(Nothing());
    // return Failure(DioException.badResponse(
    //     statusCode: 100, requestOptions: RequestOptions(), response: Response(requestOptions: RequestOptions())));
  }

  @override
  Future<Result<Nothing, DioException>> signUp({
    required String email,
    required String username,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 3));

    // _authenticationController.add(AuthenticationStatus.authenticated);

    return const Success(Nothing());
  }

  @override
  void logOut() {
    _authenticationController.add(AuthenticationStatus.unauthenticated);
    _secureStorage.deleteAll();
  }

  @override
  void checkAuthenticationStatus() async {
    final savedToken = await _secureStorage.read(key: SecureStorageKeys.authToken);

    if (savedToken == null) {
      _authenticationController.add(AuthenticationStatus.unauthenticated);
    } else {
      _authenticationController.add(AuthenticationStatus.authenticated);
    }
  }

  @override
  Future<bool> tryRefreshToken() async {
    return await Future.delayed(Duration.zero, () => true);
  }
}
