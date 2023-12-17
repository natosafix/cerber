import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager_dio/flutter_cache_manager_dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/data/datasources/local/events_database/collections/event_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/visitor_collection.dart';
import 'package:project/data/datasources/local/events_database/events_database.dart';
import 'package:project/data/datasources/remote/authentication_service/authentication_service.dart';
import 'package:project/data/datasources/remote/events_service/events_service.dart';
import 'package:project/data/datasources/remote/events_service/interceptor.dart';
import 'package:project/data/repositories/authentication_repository_impl.dart';
import 'package:project/data/repositories/compound_events_repo.dart';
import 'package:project/data/repositories/local_events_repository_impl.dart';
import 'package:project/data/repositories/mock/mock_auth_repo.dart';
import 'package:project/data/repositories/mock/mock_events_repo.dart';
import 'package:project/data/repositories/remote_events_repository_impl.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_repository.dart';
import 'package:project/domain/repositories/events_repository/events_repository.dart';
import 'package:project/domain/repositories/local_events_repository/local_events_repository.dart';
import 'package:project/utils/constants/constants.dart';

class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

final locator = GetIt.instance;

void setupLocator() async {
  if (kDebugMode) HttpOverrides.global = _MyHttpOverrides();

  locator.registerSingleton<FlutterSecureStorage>(
    const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
  );

  // locator.registerSingleton<AuthenticationRepository>(
  //   MockAuthRepo(),
  // );

  // locator.registerSingleton<EventsRepository>(
  //   MockEventsRepo(),
  //   instanceName: 'remote',
  // );

  locator.registerSingleton<AuthenticationService>(
    AuthenticationService(
      Dio(),
      baseUrl: Constants.authenticationRepositoryBaseUrl,
    ),
  );
  locator.registerSingleton<AuthenticationRepository>(
    AuthenticationRepositoryImpl(
      authenticationService: locator<AuthenticationService>(),
    ),
  );

  locator.registerSingleton<Dio>(
    Dio(
      BaseOptions(baseUrl: Constants.eventsRepositoryBaseUrl),
    )..interceptors.add(EventsServiceInterceptor()),
  );
  locator.registerSingleton<EventsService>(
    EventsService(locator<Dio>()),
  );
  locator.registerSingleton<EventsRepository>(
    RemoteEventsRepositoryImpl(eventsService: locator<EventsService>()),
    instanceName: 'remote',
  );

  DioCacheManager.initialize(locator<Dio>());

  locator.registerSingletonAsync<Isar>(() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [EventCollectionSchema, VisitorCollectionSchema],
      directory: dir.path,
    );
    return isar;
  });

  locator.registerSingletonAsync<EventsDatabase>(() async {
    final isar = await locator.getAsync<Isar>();
    return EventsDatabase(isar: isar);
  });

  locator.registerSingletonAsync<LocalEventsRepository>(() async {
    final eventDatabase = await locator.getAsync<EventsDatabase>();
    return LocalEventsRepositoryImpl(eventsDatabase: eventDatabase);
  });

  locator.registerSingletonAsync<EventsRepository>(() async {
    final localEventsRepo = await locator.getAsync<LocalEventsRepository>();
    final remoteEventsRepo = locator.get<EventsRepository>(instanceName: 'remote');
    final compoundRepo = CompoundEventsRepository(
      remoteEventsRepo: remoteEventsRepo,
      localEventsRepo: localEventsRepo,
    );
    await compoundRepo.init();
    return compoundRepo;
  });
}
