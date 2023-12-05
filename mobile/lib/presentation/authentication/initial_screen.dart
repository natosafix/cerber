import 'package:flutter/material.dart';
import 'package:project/l10n/generated/l10n.dart';

import 'login_signup/login_signup_screen.dart';

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
            const FlutterLogo(
              size: 300,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => _signUpPressed(context),
                child: Text(L10n.current.signUp),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => _logInPressed(context),
                child: Text(L10n.current.logIn),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signUpPressed(BuildContext context) {
    Navigator.of(context).push(
      LoginSignupScreen.route(withName: true),
    );
  }

  void _logInPressed(BuildContext context) {
    Navigator.of(context).push(
      LoginSignupScreen.route(withName: false),
    );
  }
}
