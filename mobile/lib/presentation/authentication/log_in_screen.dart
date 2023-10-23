import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/requests/log_in_request.dart';
import '../../domain/repositories/authentication_repository.dart';
import 'authentication_bloc/authentication_bloc.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: 'Почта',
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Пароль',
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => _logInPressed(context),
                child: const Text('Войти'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logInPressed(BuildContext context) async {
    final res =
        await context.read<AuthenticationRepository>().logIn(LogInRequest(email: "email", password: "password"));

    context.read<AuthenticationBloc>().add(AuthenticationLogInEvent(token: res.success.token));
  }
}
