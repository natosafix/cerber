import 'package:project/domain/repositories/authentication_repository/authentication_repository.dart';
import 'package:project/domain/repositories/local_events_repository.dart';
import 'package:project/utils/locator.dart';

class LogOutUsecase {
  final _authenticationRepository = locator<AuthenticationRepository>();
  final _localEventsRepository = locator<LocalEventsRepository>();

  void call() {
    _authenticationRepository.logOut();
    _localEventsRepository.deleteAllData();
  }
}
