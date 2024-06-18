sealed class AuthenticationFormStatus {
  const AuthenticationFormStatus();
}

final class UnknownStatus extends AuthenticationFormStatus {
  const UnknownStatus();
}

final class Processing extends AuthenticationFormStatus {
  const Processing();
}

final class Success extends AuthenticationFormStatus {
  const Success();
}

final class Failure extends AuthenticationFormStatus {
  const Failure({required this.errorMessage});

  final String errorMessage;
}
