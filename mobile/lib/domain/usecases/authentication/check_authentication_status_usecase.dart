import 'package:project/domain/repositories/authentication_repository/authentication_repository.dart';
import 'package:project/utils/locator.dart';

class CheckAuthenticationStatusUsecase {
  final _authenticationRepository = locator<AuthenticationRepository>();

  void call() {
    _authenticationRepository.checkAuthenticationStatus();
  }
}
