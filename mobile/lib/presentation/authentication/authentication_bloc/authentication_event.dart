part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {}

final class AuthenticationCheck extends AuthenticationEvent {}

final class AuthenticationLogInEvent extends AuthenticationEvent {
  final String token;

  AuthenticationLogInEvent({required this.token});
}

final class AuthenticationLogOutEvent extends AuthenticationEvent {}
