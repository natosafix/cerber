import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_status.dart';
import 'package:project/domain/usecases/authentication/check_authentication_status_usecase.dart';
import 'package:project/domain/usecases/authentication/log_out_usecase.dart';
import 'package:project/domain/usecases/authentication/watch_authentication_status_usecase.dart';
import 'package:project/utils/locator.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(Unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<_CheckAuthentication>(_onCheckAuthentication);
    on<Unauthenticate>(_onUnauthenticate);

    _authStatusSubscription = _watchAuthenticationStatusUsecase().listen((status) {
      add(_AuthenticationStatusChanged(status));
    });

    add(_CheckAuthentication());
  }

  late final StreamSubscription<AuthenticationStatus> _authStatusSubscription;

  final _logOutUsecase = locator<LogOutUsecase>();
  final _watchAuthenticationStatusUsecase = locator<WatchAuthenticationStatusUsecase>();
  final _checkAuthenticationStatusUsecase = locator<CheckAuthenticationStatusUsecase>();

  void _onAuthenticationStatusChanged(
      _AuthenticationStatusChanged event, Emitter<AuthenticationState> emit) {
    switch (event.status) {
      case AuthenticationStatus.authenticated:
        emit(Authenticated());
      case AuthenticationStatus.unauthenticated:
        emit(Unauthenticated());
    }
  }

  void _onCheckAuthentication(_CheckAuthentication event, Emitter<AuthenticationState> emit) {
    _checkAuthenticationStatusUsecase();
  }

  void _onUnauthenticate(Unauthenticate event, Emitter<AuthenticationState> emit) {
    _logOutUsecase();
  }

  @override
  Future<void> close() async {
    await _authStatusSubscription.cancel();
    return super.close();
  }
}
