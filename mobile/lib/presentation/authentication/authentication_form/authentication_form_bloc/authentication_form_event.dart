part of 'authentication_form_bloc.dart';

sealed class AuthenticationFormEvent {
  const AuthenticationFormEvent();
}

final class EmailChanged extends AuthenticationFormEvent {
  const EmailChanged(this.email);

  final String email;
}

final class NameChanged extends AuthenticationFormEvent {
  const NameChanged(this.name);

  final String name;
}

final class PasswordChanged extends AuthenticationFormEvent {
  const PasswordChanged(this.password);

  final String password;
}

final class FinishPressed extends AuthenticationFormEvent {
  const FinishPressed();
}
