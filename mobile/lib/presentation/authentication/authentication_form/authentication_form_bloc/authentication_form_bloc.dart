import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_repository.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_bloc/authentication_form_status.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_bloc/formz_inputs/email.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_bloc/formz_inputs/name.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_bloc/formz_inputs/password.dart';
import 'package:project/utils/locator.dart';

part 'authentication_form_event.dart';
part 'authentication_form_state.dart';

abstract class AuthenticationFormBloc extends Bloc<AuthenticationFormEvent, AuthenticationFormState> {
  AuthenticationFormBloc(
    AuthenticationFormState initialState,
  ) : super(initialState) {
    on<EmailChanged>(_onEmailChanged);
    on<NameChanged>(_onNameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<FinishPressed>(onFinishPressed);
  }

  @protected
  final authenticationRepository = locator<AuthenticationRepository>();

  void _onEmailChanged(EmailChanged event, Emitter<AuthenticationFormState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email));
  }

  void _onNameChanged(NameChanged event, Emitter<AuthenticationFormState> emit) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(name: name));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthenticationFormState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(password: password));
  }

  @protected
  void onFinishPressed(FinishPressed event, Emitter<AuthenticationFormState> emit);
}
