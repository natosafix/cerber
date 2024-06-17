import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:project/domain/usecases/authentication/log_in_usecase.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/authentication/authentication_form/formz_inputs/email.dart';
import 'package:project/presentation/authentication/authentication_form/formz_inputs/password.dart';
import 'package:project/presentation/authentication/authentication_form/shared/authentication_form_status.dart';
import 'package:project/utils/locator.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : super(LoginState(
          email: Email.pure(),
          password: const Password.pure(),
          authenticationFormStatus: const UnknownStatus(),
        )) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<FinishPressed>(_onFinishPressed);
  }

  final _logInUsecase = locator<LogInUsecase>();

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(password: password));
  }

  void _onFinishPressed(FinishPressed event, Emitter<LoginState> emit) async {
    emit(state.copyWith(authenticationFormStatus: const Processing()));

    final res = await _logInUsecase(
      email: state.email.value.trim(),
      password: state.password.value.trim(),
    );

    if (res.isSuccess) {
      return emit(state.copyWith(authenticationFormStatus: const Success()));
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

    emit(state.copyWith(authenticationFormStatus: Failure(errorMessage: errorMessage)));
    emit(state.copyWith(authenticationFormStatus: const UnknownStatus()));
  }
}
