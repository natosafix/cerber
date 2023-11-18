import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/mock_auth_repo.dart';
import 'domain/repositories/authentication_repository/authentication_repository.dart';
import 'presentation/app.dart';
import 'presentation/authentication/authentication_bloc/authentication_bloc.dart';

void main() async {
  final mockAuthRepo = MockAuthRepo();

  final app = RepositoryProvider<AuthenticationRepository>.value(
    value: mockAuthRepo,
    child: BlocProvider(
      create: (context) => AuthenticationBloc()..add(CheckAuthentication()),
      child: const MainApp(),
    ),
  );

  runApp(app);
}
