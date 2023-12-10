part of 'authentication_form_bloc.dart';

final class AuthenticationFormState {
  const AuthenticationFormState({
    required this.email,
    this.name,
    required this.password,
    this.authenticationStatus = const UnknownStatus(),
  });

  final Email email;
  final Name? name;
  final Password password;
  final AuthenticationFormStatus authenticationStatus;

  bool get isValid => Formz.validate([
        email,
        if (name != null) name!,
        password,
      ]);

  bool get isProcessing => authenticationStatus is Processing;

  AuthenticationFormState copyWith({
    Email? email,
    Name? name,
    Password? password,
    AuthenticationFormStatus? authenticationStatus,
  }) {
    return AuthenticationFormState(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      authenticationStatus: authenticationStatus ?? this.authenticationStatus,
    );
  }
}
