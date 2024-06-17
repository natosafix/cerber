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
import 'package:project/data/datasources/local/events_database/collections/ticket_collection/ticket_collection.dart';
import 'package:project/data/datasources/local/events_database/collections/visitor_collection/visitor_collection.dart';
import 'package:project/data/datasources/local/events_database/events_database.dart';
import 'package:project/data/datasources/remote/authentication_service/authentication_service.dart';
import 'package:project/data/datasources/remote/events_service/events_service.dart';
import 'package:project/data/datasources/remote/events_service/interceptor.dart';
import 'package:project/data/repositories/authentication_repository_impl.dart';
import 'package:project/data/repositories/local_events_repository_impl.dart';
import 'package:project/data/repositories/mock/mock_auth_repo.dart';
import 'package:project/data/repositories/mock/mock_events_repo.dart';
import 'package:project/data/repositories/remote_events_repository_impl.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_repository.dart';
import 'package:project/domain/repositories/local_events_repository.dart';
import 'package:project/domain/repositories/remote_events_repository.dart';
import 'package:project/domain/usecases/add_new_visitor_usecase.dart';
import 'package:project/domain/usecases/authentication/check_authentication_status_usecase.dart';
import 'package:project/domain/usecases/authentication/log_in_usecase.dart';
import 'package:project/domain/usecases/authentication/log_out_usecase.dart';
import 'package:project/domain/usecases/authentication/sign_up_usecase.dart';
import 'package:project/domain/usecases/authentication/watch_authentication_status_usecase.dart';
import 'package:project/domain/usecases/download_database_usecase.dart';
import 'package:project/domain/usecases/find_visitor_usecase.dart';
import 'package:project/domain/usecases/generate_new_qr_code_usecase.dart';
import 'package:project/domain/usecases/get_events_usecase.dart';
import 'package:project/domain/usecases/get_questions_usecase.dart';
import 'package:project/domain/usecases/get_tickets_usecase.dart';
import 'package:project/domain/usecases/process_qr_code_usecase.dart';
import 'package:project/domain/usecases/send_generated_visitors_usecase.dart';
import 'package:project/domain/usecases/watch_event_usecase.dart';
import 'package:project/domain/usecases/watch_generated_visitors_count_usecase.dart';
import 'package:project/utils/cryptor/cryptor.dart';
import 'package:project/utils/cryptor/cryptor_impl.dart';
import 'package:project/utils/geocoder/geocoder.dart';
import 'package:project/utils/geocoder/geocoder_impl.dart';
import 'package:project/utils/network_checker/network_checker.dart';
import 'package:project/utils/network_checker/network_checker_impl.dart';
import 'package:project/utils/constants/constants.dart';

class _BadCertificateIgnoringHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

final locator = GetIt.instance;

const _mockRepos = false;

Future<void> setupLocator() async {
  if (kDebugMode) HttpOverrides.global = _BadCertificateIgnoringHttpOverrides();

  locator.registerSingleton<FlutterSecureStorage>(
    const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
  );

  locator.registerSingleton<NetworkChecker>(NetworkCheckerImpl());

  locator.registerLazySingleton<Cryptor>(() => CryptorImpl());

  locator.registerLazySingleton<Geocoder>(() => GeocoderImpl());

  locator.registerSingleton<LocalEventsRepository>(await () async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [
        EventCollectionSchema,
        VisitorCollectionSchema,
        QuestionCollectionSchema,
        AnswerCollectionSchema,
        TicketCollectionSchema,
      ],
      directory: dir.path,
    );
    final eventsDatabase = EventsDatabase(isar: isar);
    return LocalEventsRepositoryImpl(eventsDatabase: eventsDatabase);
  }());

  locator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: Constants.eventsRepositoryBaseUrl,
        // connectTimeout: const Duration(seconds: 120),
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

  locator.registerSingleton<CheckAuthenticationStatusUsecase>(CheckAuthenticationStatusUsecase());
  locator.registerSingleton<LogInUsecase>(LogInUsecase());
  locator.registerSingleton<LogOutUsecase>(LogOutUsecase());
  locator.registerSingleton<SignUpUsecase>(SignUpUsecase());
  locator.registerSingleton<WatchAuthenticationStatusUsecase>(WatchAuthenticationStatusUsecase());

  locator.registerSingleton<AddNewVisitorUsecase>(AddNewVisitorUsecase());
  locator.registerSingleton<DownloadDatabaseUsecase>(DownloadDatabaseUsecase());
  locator.registerSingleton<FindVisitorUsecase>(FindVisitorUsecase());
  locator.registerSingleton<GenerateNewQrCodeUsecase>(GenerateNewQrCodeUsecase());
  locator.registerSingleton<GetEventsUsecase>(GetEventsUsecase());
  locator.registerSingleton<GetQuestionsUsecase>(GetQuestionsUsecase());
  locator.registerSingleton<GetTicketsUsecase>(GetTicketsUsecase());
  locator.registerSingleton<ProcessQrCodeUsecase>(ProcessQrCodeUsecase());
  locator.registerSingleton<SendGeneratedVisitorsUsecase>(SendGeneratedVisitorsUsecase());
  locator.registerSingleton<WatchEventUsecase>(WatchEventUsecase());
  locator.registerSingleton<WatchGeneratedVisitorsCountUsecase>(WatchGeneratedVisitorsCountUsecase());

  DioCacheManager.initialize(locator<Dio>());
}
