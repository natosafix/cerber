import 'package:flutter/material.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/authentication/authentication_form/login/login_screen.dart';
import 'package:project/presentation/authentication/authentication_form/signup/signup_screen.dart';
import 'package:project/presentation/widgets/full_width_button.dart';
import 'package:project/utils/extensions/context_x.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (context) => const InitialScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
      ),
    );
  }

  void _signUpPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

  void _logInPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}
