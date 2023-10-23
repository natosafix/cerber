import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication/authentication_bloc/authentication_bloc.dart';

class Temp extends StatelessWidget {
  const Temp({
    super.key,
    required this.token,
  });

  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Main screen; token: $token"),
          FilledButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(AuthenticationLogOutEvent());
            },
            child: const Text("Выйти"),
          ),
        ],
      ),
    );
  }
}
