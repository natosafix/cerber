part of 'login_bloc.dart';

sealed class LoginEvent {}

final class EmailChanged extends LoginEvent {
  EmailChanged(this.email);

  final String email;
}

final class PasswordChanged extends LoginEvent {
  PasswordChanged(this.password);

  final String password;
}

final class FinishPressed extends LoginEvent {}
