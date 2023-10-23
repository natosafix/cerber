part of 'login_signup_bloc.dart';

final class LoginSignupState {
  const LoginSignupState({
    required this.email,
    this.name,
    required this.password,
  });

  final Email email;
  final Name? name;
  final Password password;

  bool get isValid => Formz.validate([email, if (name != null) name!, password]);

  LoginSignupState copyWith({
    Email? email,
    Name? name,
    Password? password,
  }) {
    return LoginSignupState(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
    );
  }
}
