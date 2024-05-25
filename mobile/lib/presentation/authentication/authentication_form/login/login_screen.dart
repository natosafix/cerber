import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/authentication/authentication_form/shared/authentication_form_status.dart';
import 'package:project/presentation/authentication/authentication_form/shared/authentication_screen_base.dart';
import 'package:project/presentation/authentication/authentication_form/widget_inputs/email_input.dart';
import 'package:project/presentation/authentication/authentication_form/widget_inputs/password_input.dart';
import 'package:project/presentation/authentication/authentication_form/shared/finish_button_widget.dart';
import 'package:project/presentation/authentication/authentication_form/login/login_bloc/login_bloc.dart';
import 'package:project/utils/extensions/context_x.dart';
import 'package:project/utils/keyboard_utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: AuthenticationScreenBase(
        title: L10n.current.logIntoAccount,
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            _authenticationFormStatusChanged(state.authenticationFormStatus, context);
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmailInput(
                  isEnabled: state.areFieldsEnabled,
                  errorText: state.email.displayError?.errorMessage,
                  onChanged: (value) => context.read<LoginBloc>().add(EmailChanged(value)),
                ),
                PasswordInput(
                  isEnabled: state.areFieldsEnabled,
                  errorText: state.password.displayError?.errorMessage,
                  onChanged: (value) => context.read<LoginBloc>().add(PasswordChanged(value)),
                ),
                const SizedBox(height: 20),
                FinishButtonWigdet(
                  text: L10n.current.logIn,
                  isEnabled: state.isFinishButtonEnabled, 
                  showLoadingIndicator: state.showLoadingIndicator,
                  onPressed: () => context.read<LoginBloc>().add(FinishPressed()),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _authenticationFormStatusChanged(AuthenticationFormStatus status, BuildContext context) {
    switch (status) {
      case Processing():
        KeyboardUtils.dismiss();
      case Failure():
        context.showSnackbar(status.errorMessage);
      case Success() || UnknownStatus():
        break;
    }
  }
}
