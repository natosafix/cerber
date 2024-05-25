import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_repository.dart';
import 'package:project/presentation/authentication/authentication_form/formz_inputs/email.dart';
import 'package:project/presentation/authentication/authentication_form/formz_inputs/password.dart';
import 'package:project/presentation/authentication/authentication_form/shared/authentication_form_status.dart';
import 'package:project/presentation/authentication/authentication_form/formz_inputs/name.dart';
import 'package:project/utils/locator.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc()
      : super(SignupState(
          email: Email.pure(),
          name: const Name.pure(),
          password: const Password.pure(),
          authenticationFormStatus: const UnknownStatus(),
        )) {
    on<EmailChanged>(_onEmailChanged);
    on<NameChanged>(_onNameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<FinishPressed>(_onFinishPressed);
  }

  final _authenticationRepository = locator<AuthenticationRepository>();

  void _onEmailChanged(EmailChanged event, Emitter<SignupState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email));
  }

  void _onNameChanged(NameChanged event, Emitter<SignupState> emit) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(name: name));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignupState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(password: password));
  }

  void _onFinishPressed(FinishPressed event, Emitter<SignupState> emit) async {
    emit(state.copyWith(authenticationFormStatus: const Processing()));

    final res = await _authenticationRepository.signUp(
      email: state.email.value.trim(),
      username: state.name.value.trim(),
      password: state.password.value.trim(),
    );

    if (res.isSuccess) {
      return emit(state.copyWith(authenticationFormStatus: const Success()));
    }

    final error = res.failure.message ?? "Unknown Error";
    debugPrint(res.failure.stackTrace.toString());

    emit(state.copyWith(authenticationFormStatus: Failure(errorMessage: error)));
    emit(state.copyWith(authenticationFormStatus: const UnknownStatus()));
  }
}
