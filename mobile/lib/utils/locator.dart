import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager_dio/flutter_cache_manager_dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/data/datasources/local/events_database/collections/answer_collection/answer_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/event_collection/event_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/question_collection/question_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/visitor_collection/visitor_collection.dart';
import 'package:project/data/datasources/local/events_database/events_database.dart';
import 'package:project/data/datasources/remote/authentication_service/authentication_service.dart';
import 'package:project/data/datasources/remote/events_service/events_service.dart';
import 'package:project/data/datasources/remote/events_service/interceptor.dart';
import 'package:project/data/repositories/authentication_repository_impl.dart';
import 'package:project/data/repositories/compound_events_repository_impl.dart';
import 'package:project/data/repositories/local_events_repository_impl.dart';
import 'package:project/data/repositories/mock/mock_auth_repo.dart';
import 'package:project/data/repositories/mock/mock_events_repo.dart';
import 'package:project/data/repositories/remote_events_repository_impl.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_repository.dart';
import 'package:project/domain/repositories/compound_events_repository/compound_events_repository.dart';
import 'package:project/domain/repositories/events_repository.dart';
import 'package:project/domain/repositories/local_events_repository.dart';
import 'package:project/domain/repositories/remote_events_repository.dart';
import 'package:project/utils/cryptor/cryptor.dart';
import 'package:project/utils/cryptor/cryptor_impl.dart';
import 'package:project/utils/network_checker/network_checker.dart';
import 'package:project/utils/network_checker/network_checker_impl.dart';
import 'package:project/utils/constants/constants.dart';

class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

final locator = GetIt.instance;

const _mockRepos = false;

void setupLocator() async {
  if (kDebugMode) HttpOverrides.global = _MyHttpOverrides();

  locator.registerSingleton<FlutterSecureStorage>(
    const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
  );

  locator.registerSingleton<NetworkChecker>(NetworkCheckerImpl());

  locator.registerSingleton<Cryptor>(CryptorImpl());

  locator.registerSingletonAsync<LocalEventsRepository>(() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [EventCollectionSchema, VisitorCollectionSchema, QuestionCollectionSchema, AnswerCollectionSchema],
      directory: dir.path,
    );
    final eventsDatabase = EventsDatabase(isar: isar);
    return LocalEventsRepositoryImpl(eventsDatabase: eventsDatabase);
  });

  locator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: Constants.eventsRepositoryBaseUrl,
        connectTimeout: const Duration(seconds: 20),
      ),
    )..interceptors.add(EventsServiceInterceptor()),
  );

  if (_mockRepos) {
    locator.registerSingleton<AuthenticationRepository>(
      MockAuthRepo(),
    );

    locator.registerSingleton<RemoteEventsRepository>(
      MockEventsRepo(),
    );
  } else {
    locator.registerSingleton<AuthenticationRepository>(
      AuthenticationRepositoryImpl(
        authenticationService: AuthenticationService(
          Dio(),
          baseUrl: Constants.authenticationRepositoryBaseUrl,
        ),
      ),
    );

    locator.registerSingleton<RemoteEventsRepository>(
      RemoteEventsRepositoryImpl(
        eventsService: EventsService(locator<Dio>()),
      ),
    );
  }

  locator.registerSingletonAsync<CompoundEventsRepository>(() async {
    final localEventsRepo = await locator.getAsync<LocalEventsRepository>();
    final compoundRepo = CompoundEventsRepositoryImpl(
      remoteEventsRepository: locator<RemoteEventsRepository>(),
      localEventsRepository: localEventsRepo,
    );
    await compoundRepo.init();
    return compoundRepo;
  });

  locator.registerSingletonAsync<EventsRepository>(
    () async => await locator.getAsync<CompoundEventsRepository>(),
  );

  DioCacheManager.initialize(locator<Dio>());
}
