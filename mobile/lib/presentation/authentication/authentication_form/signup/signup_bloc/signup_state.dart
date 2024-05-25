part of 'signup_bloc.dart';

final class SignupState {
  const SignupState({
    required this.email,
    required this.name,
    required this.password,
    required this.authenticationFormStatus,
  });

  final Email email;
  final Name name;
  final Password password;
  final AuthenticationFormStatus authenticationFormStatus;

  bool get isFormValid => Formz.validate([email, name, password]);

  bool get areFieldsEnabled => !_isProcessing;

  bool get isFinishButtonEnabled => isFormValid && !_isProcessing;

  bool get showLoadingIndicator => _isProcessing;

  bool get _isProcessing => authenticationFormStatus is Processing;

  SignupState copyWith({
    Email? email,
    Name? name,
    Password? password,
    AuthenticationFormStatus? authenticationFormStatus,
  }) {
    return SignupState(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      authenticationFormStatus: authenticationFormStatus ?? this.authenticationFormStatus,
    );
  }
}
