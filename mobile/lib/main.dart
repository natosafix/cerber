import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_repository.dart';
import 'package:project/domain/repositories/events_repository.dart';
import 'package:project/presentation/app.dart';
import 'package:project/presentation/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:project/utils/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  final eventsRepository = await locator.getAsync<EventsRepository>();

  final app = MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (context) => eventsRepository),
      RepositoryProvider(create: (context) => locator<AuthenticationRepository>()),
    ],
    child: BlocProvider(
      create: (context) => AuthenticationBloc(context.read<AuthenticationRepository>())..add(CheckAuthentication()),
      child: const MainApp(),
    ),
  );

  runApp(app);
}
