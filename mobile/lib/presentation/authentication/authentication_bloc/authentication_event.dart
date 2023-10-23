part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {}

final class CheckAuthentication extends AuthenticationEvent {}

final class Authenticate extends AuthenticationEvent {
  final String token;

  Authenticate({required this.token});
}

final class Unauthenticate extends AuthenticationEvent {}
