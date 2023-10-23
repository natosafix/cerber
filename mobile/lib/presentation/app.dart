import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication/authentication_bloc/authentication_bloc.dart';
import 'authentication/signup_or_login_screen.dart';
import 'splash_page.dart';
import 'temp.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state) {
              case Authenticated(token: final token):
                _navigator.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Temp(token: token)),
                  (route) => false,
                );
              case Unauthenticated():
                _navigator.pushAndRemoveUntil(
                  SignUpOrLogInScreen.route(),
                  (route) => false,
                );
              case Unknown():
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
