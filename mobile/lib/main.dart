import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/presentation/app.dart';
import 'package:project/presentation/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:project/utils/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await setupLocator();

  final app = BlocProvider(
    create: (context) => AuthenticationBloc(),
    child: const MainApp(),
  );

  runApp(app);
}
