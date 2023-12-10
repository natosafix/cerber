part of 'authentication_bloc.dart';

sealed class AuthenticationState {}

final class Unknown extends AuthenticationState {}

final class Authenticated extends AuthenticationState {
  final String token;

  Authenticated({required this.token});
}

final class Unauthenticated extends AuthenticationState {}
