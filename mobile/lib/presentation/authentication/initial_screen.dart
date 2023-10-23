import 'package:flutter/material.dart';
import 'package:project/presentation/authentication/login_signup/login_signup_screen.dart';

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
                child: const Text("Зарегаться"),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => _logInPressed(context),
                child: const Text("Войти"),
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
