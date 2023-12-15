part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {}

final class _AuthenticationStatusChanged extends AuthenticationEvent {
  _AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;
}

final class CheckAuthentication extends AuthenticationEvent {}

final class Authenticate extends AuthenticationEvent {}

final class Unauthenticate extends AuthenticationEvent {}
