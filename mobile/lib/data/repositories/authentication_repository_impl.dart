import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/data/datasources/remote/authentication_service/authentication_service.dart';
import 'package:project/data/datasources/remote/authentication_service/requests/log_in_request.dart';
import 'package:project/data/datasources/remote/authentication_service/requests/register_request.dart';
import 'package:project/data/datasources/remote/authentication_service/responses/log_in_response.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_repository.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_status.dart';
import 'package:project/utils/constants/secure_storage_keys.dart';
import 'package:project/utils/locator.dart';
import 'package:project/utils/result.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl({
    required AuthenticationService authenticationService,
  }) : _authenticationService = authenticationService;

  final AuthenticationService _authenticationService;

  final _secureStorage = locator<FlutterSecureStorage>();

  final _authenticationController = StreamController<AuthenticationStatus>();

  @override
  Stream<AuthenticationStatus> get authenticationStatus async* {
    yield* _authenticationController.stream;
  }

  @override
  Future<Result<Nothing, DioException>> logIn({
    required String email,
    required String password,
  }) async {
    final logInResult = await _logIn(email: email, password: password);

    if (logInResult.isFailure) return Failure(logInResult.failure);

    final response = logInResult.success;

    await Future.wait([
      _secureStorage.write(key: SecureStorageKeys.authToken, value: response.token),
      _secureStorage.write(key: SecureStorageKeys.authTokenExpiration, value: response.expiration.toString()),
      _secureStorage.write(key: SecureStorageKeys.userEmail, value: email),
      _secureStorage.write(key: SecureStorageKeys.userPassword, value: password),
    ]);

    _authenticationController.add(AuthenticationStatus.authenticated);

    return const Success(Nothing());
  }

  Future<Result<LogInResponse, DioException>> _logIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authenticationService.login(LogInRequest(
        username: email, // TODO: passing email as username
        password: password,
      ));
      return Success(response);
    } on DioException catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<Nothing, DioException>> signUp({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      await _authenticationService.register(RegisterRequest(
        username: username,
        password: password,
        email: email,
      ));
      return const Success(Nothing());
    } on DioException catch (e) {
      return Failure(e);
    }
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
      return _authenticationController.add(AuthenticationStatus.unauthenticated);
    }

    final isTokenValid = await _isTokenValid();

    if (isTokenValid) {
      return _authenticationController.add(AuthenticationStatus.authenticated);
    }
    
    await tryRefreshToken();
  }

  @override
  Future<bool> tryRefreshToken() async {
    final email = await _secureStorage.read(key: SecureStorageKeys.userEmail);
    final password = await _secureStorage.read(key: SecureStorageKeys.userPassword);

    failed() => logOut();

    if (email == null || password == null) {
      failed();
      return false;
    }

    final logInResult = await _logIn(email: email, password: password);

    if (logInResult.isFailure) {
      failed();
      return false;
    }

    final response = logInResult.success;

    await Future.wait([
      _secureStorage.write(key: SecureStorageKeys.authToken, value: response.token),
      _secureStorage.write(key: SecureStorageKeys.authTokenExpiration, value: response.expiration.toString()),
    ]);

    _authenticationController.add(AuthenticationStatus.authenticated);

    return true;
  }

  Future<bool> _isTokenValid() async {
    final tokenExpiration = await _secureStorage.read(key: SecureStorageKeys.authTokenExpiration);

    if (tokenExpiration == null) return false;

    final expires = DateTime.parse(tokenExpiration);
    const threshold = Duration(minutes: 10);

    return DateTime.now().add(threshold).isBefore(expires);
  }
}
