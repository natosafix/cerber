import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../domain/repositories/authentication_repository/authentication_repository.dart';
import '../../../../domain/repositories/authentication_repository/requests/log_in_request.dart';
import '../../../../domain/repositories/authentication_repository/requests/sign_up_request.dart';
import '../../../../utils/result.dart';
import 'formz_inputs/email.dart';
import 'formz_inputs/name.dart';
import 'formz_inputs/password.dart';

part 'login_signup_event.dart';
part 'login_signup_state.dart';

class LoginSignupBloc extends Bloc<LoginSignupEvent, LoginSignupState> {
  LoginSignupBloc({
    required bool withName,
    required AuthenticationRepository authenticationRepository,
  })  : _withName = withName,
        _authenticationRepository = authenticationRepository,
        super(LoginSignupState(
          email: Email.pure(),
          name: withName ? const Name.pure() : null,
          password: const Password.pure(),
        )) {
    on<EmailChanged>(_onEmailChanged);
    on<NameChanged>(_onNameChanged);
    on<PasswordChanged>(_onPasswordChanged);
  }

  final bool _withName;
  final AuthenticationRepository _authenticationRepository;

  void _onEmailChanged(EmailChanged event, Emitter<LoginSignupState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email));
  }

  void _onNameChanged(NameChanged event, Emitter<LoginSignupState> emit) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(name: name));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginSignupState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(password: password));
  }

  Future<Result<String, DioException>> finish() async {
    final email = state.email.value.trim();
    final password = state.password.value.trim();

    if (_withName) {
      final res = await _authenticationRepository.signUp(SignUpRequest(
        email: email,
        password: password,
        name: state.name!.value.trim(),
      ));

      if (res.isSuccess) return Success(res.success.token);

      return Failure(res.failure);
    }

    final res = await _authenticationRepository.logIn(LogInRequest(
      email: email,
      password: password,
    ));

    if (res.isSuccess) return Success(res.success.token);

    return Failure(res.failure);
  }
}
