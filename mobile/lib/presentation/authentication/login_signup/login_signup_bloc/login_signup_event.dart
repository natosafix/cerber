part of 'login_signup_bloc.dart';

sealed class LoginSignupEvent {
  const LoginSignupEvent();
}

final class EmailChanged extends LoginSignupEvent {
  const EmailChanged(this.email);

  final String email;
}

final class NameChanged extends LoginSignupEvent {
  const NameChanged(this.name);

  final String name;
}

final class PasswordChanged extends LoginSignupEvent {
  const PasswordChanged(this.password);

  final String password;
}