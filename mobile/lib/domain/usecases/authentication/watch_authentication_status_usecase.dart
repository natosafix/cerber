import 'package:project/domain/repositories/authentication_repository/authentication_repository.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_status.dart';
import 'package:project/utils/locator.dart';

class WatchAuthenticationStatusUsecase {
  final _authenticationRepository = locator<AuthenticationRepository>();

  Stream<AuthenticationStatus> call() async* {
    yield* _authenticationRepository.authenticationStatus;
  }
}
