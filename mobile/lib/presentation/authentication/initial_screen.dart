import 'package:flutter/material.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_bloc/log_in_bloc.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_bloc/sign_up_bloc.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_screen/authentication_form_screen.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_screen/inputs/email_input.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_screen/inputs/name_input.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_screen/inputs/password_input.dart';
import 'package:project/presentation/widgets/full_width_button.dart';
import 'package:project/utils/extensions/context_x.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (context) => const InitialScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/${context.isLight() ? 'logo_light.png' : 'logo_dark.png'}"),
            const SizedBox(height: 150),
            FullWidthButton(
              onPressed: () => _signUpPressed(context),
              child: Text(L10n.current.signUp),
            ),
            const SizedBox(height: 8),
            FullWidthButton(
              onPressed: () => _logInPressed(context),
              child: Text(L10n.current.logIn),
            ),
          ],
        ),
      ),
    );
  }

  void _signUpPressed(BuildContext context) {
    final signUpScreen = AuthenticationFormScreenBase(
      authenticationFormBloc: SignUpBloc(),
      inputFields: const [EmailInput(), NameInput(), PasswordInput()],
      title: L10n.current.createAccount,
      finishButtonText: L10n.current.signUp,
      onSuccess: (context) {
        context.showSnackbar(L10n.current.youHaveSignUpsuccessfully);
        Navigator.of(context).pop();
      },
    );

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => signUpScreen),
    );
  }

  void _logInPressed(BuildContext context) {
    final loginScreen = AuthenticationFormScreenBase(
      authenticationFormBloc: LogInBloc(),
      inputFields: const [EmailInput(), PasswordInput()],
      title: L10n.current.logIntoAccount,
      finishButtonText: L10n.current.logIn,
      onSuccess: (context) {},
    );

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => loginScreen),
    );
  }
}
