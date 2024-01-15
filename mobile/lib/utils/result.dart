sealed class Result<S, E extends Exception> {
  const Result();

  bool get isSuccess => this is Success<S, E>;
  bool get isFailure => this is Failure<S, E>;

  S get success {
    if (isSuccess) return (this as Success<S, E>).value;

    throw Exception("Not Success");
  }

  E get failure {
    if (isFailure) return (this as Failure<S, E>).exception;

    throw Exception("Not Failure");
  }

  void fold(void Function(S success) onSuccess, void Function(E failure) onFailure) {
    if (isSuccess) {
      onSuccess(success);
    } else {
      onFailure(failure);
    }
  }
}

final class Success<S, E extends Exception> extends Result<S, E> {
  const Success(this.value);
  final S value;
}

final class Failure<S, E extends Exception> extends Result<S, E> {
  const Failure(this.exception);
  final E exception;
}

// why: 'void' doesnt work when u dont need to return anything in 'Success'
final class Nothing {
  const Nothing();
}
