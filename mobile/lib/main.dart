import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'data/datasources/local/events_database/collections/event_collection.dart';
import 'data/datasources/local/events_database/collections/visitor_collection.dart';
import 'data/datasources/local/events_database/database_adapter.dart';
import 'data/repositories/compound_events_repo.dart';
import 'data/repositories/local_events_repository_impl.dart';
import 'data/repositories/mock_auth_repo.dart';
import 'data/repositories/mock_events_repo.dart';
import 'domain/repositories/authentication_repository/authentication_repository.dart';
import 'domain/repositories/events_repository/events_repository.dart';
import 'presentation/app.dart';
import 'presentation/authentication/authentication_bloc/authentication_bloc.dart';

void main() async {
  // TODO: move dependency injection outta here
  WidgetsFlutterBinding.ensureInitialized();

  final mockAuthRepo = MockAuthRepo();

  final remoteRepo = MockEventsRepo();

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [EventCollectionSchema, VisitorCollectionSchema],
    directory: dir.path,
  );

  final localRepo = LocalEventsRepositoryImpl(databaseAdapter: DatabaseAdapter(isar: isar));

  final compoundRepo = CompoundEventsRepository(remoteEventsRepo: remoteRepo, localEventsRepo: localRepo);
  await compoundRepo.init();

  final app = RepositoryProvider<EventsRepository>.value(
    value: compoundRepo,
    child: RepositoryProvider<AuthenticationRepository>.value(
      value: mockAuthRepo,
      child: BlocProvider(
        create: (context) => AuthenticationBloc()..add(CheckAuthentication()),
        child: const MainApp(),
      ),
    ),
  );

  runApp(app);
}
