import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/l10n/generated/l10n.dart';
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

    final res = await authenticationRepository.logIn(
      email: state.email.value.trim(),
      password: state.password.value.trim(),
    );

    if (res.isSuccess) {
      return emit(state.copyWith(authenticationStatus: const Success()));
    }

    final response = res.failure.response;

    var errorMessage = "Unknown Error";

    if (response != null) {
      if (response.statusCode == 401) {
        errorMessage = L10n.current.invalidPasswordOrEmail;
      } else {
        errorMessage = res.failure.message!;
      }
    }

    emit(state.copyWith(authenticationStatus: Failure(errorMessage: errorMessage)));
    emit(state.copyWith(authenticationStatus: const UnknownStatus()));
  }
}
