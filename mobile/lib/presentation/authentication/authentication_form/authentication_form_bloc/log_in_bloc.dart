import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/repositories/authentication_repository/requests/log_in_request.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_bloc/authentication_form_bloc.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_bloc/authentication_form_status.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_bloc/formz_inputs/email.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_bloc/formz_inputs/password.dart';

class LogInBloc extends AuthenticationFormBloc {
  LogInBloc({
    required super.authenticationRepository,
  }) : super(
          initialState: AuthenticationFormState(
            email: Email.pure(),
            password: const Password.pure(),
          ),
        );

  @override
  void onFinishPressed(FinishPressed event, Emitter<AuthenticationFormState> emit) async {
    emit(state.copyWith(authenticationStatus: const Processing()));

    final res = await authenticationRepository.logIn(LogInRequest(
      email: state.email.value.trim(),
      password: state.password.value.trim(),
    ));

    if (res.isSuccess) {
      return emit(state.copyWith(authenticationStatus: const Success()));
    }

    final error = res.failure.message ?? "Unknown Error";
    debugPrint(res.failure.stackTrace.toString());

    emit(state.copyWith(authenticationStatus: Failure(errorMessage: error)));
    
    emit(state.copyWith(authenticationStatus: const UnknownStatus()));
  }
}
