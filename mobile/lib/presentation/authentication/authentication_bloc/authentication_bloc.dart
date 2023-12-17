import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_repository.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_status.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this._authenticationRepository) : super(Unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<CheckAuthentication>(_onCheckAuthentication);
    on<Authenticate>(_onAuthenticate);
    on<Unauthenticate>(_onUnauthenticate);

    _authStatusSubscription = _authenticationRepository.authenticationStatus.listen((status) {
      add(_AuthenticationStatusChanged(status));
    });
  }

  final AuthenticationRepository _authenticationRepository;

  late final StreamSubscription<AuthenticationStatus> _authStatusSubscription;

  void _onAuthenticationStatusChanged(_AuthenticationStatusChanged event, Emitter<AuthenticationState> emit) {
    switch (event.status) {
      case AuthenticationStatus.authenticated:
        emit(Authenticated());
      case AuthenticationStatus.unauthenticated:
        emit(Unauthenticated());
    }
  }

  void _onCheckAuthentication(CheckAuthentication event, Emitter<AuthenticationState> emit) {
    _authenticationRepository.checkAuthenticationStatus();
  }

  void _onAuthenticate(Authenticate event, Emitter<AuthenticationState> emit) {
    emit(Authenticated());
  }

  void _onUnauthenticate(Unauthenticate event, Emitter<AuthenticationState> emit) {
    _authenticationRepository.logOut();
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    return super.close();
  }
}
