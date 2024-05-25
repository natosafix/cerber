part of 'signup_bloc.dart';

sealed class SignupEvent {}

final class EmailChanged extends SignupEvent {
  EmailChanged(this.email);

  final String email;
}

final class NameChanged extends SignupEvent {
  NameChanged(this.name);

  final String name;
}

final class PasswordChanged extends SignupEvent {
  PasswordChanged(this.password);

  final String password;
}

final class FinishPressed extends SignupEvent {}
