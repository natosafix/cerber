part of 'login_bloc.dart';

final class LoginState {
  const LoginState({
    required this.email,
    required this.password,
    required this.authenticationFormStatus,
  });

  final Email email;
  final Password password;
  final AuthenticationFormStatus authenticationFormStatus;

  bool get isFormValid => Formz.validate([email, password]);

  bool get areFieldsEnabled => !_isProcessing;

  bool get isFinishButtonEnabled => isFormValid && !_isProcessing;

  bool get showLoadingIndicator => _isProcessing;

  bool get _isProcessing => authenticationFormStatus is Processing;

  LoginState copyWith({
    Email? email,
    Password? password,
    AuthenticationFormStatus? authenticationFormStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      authenticationFormStatus: authenticationFormStatus ?? this.authenticationFormStatus,
    );
  }
}
