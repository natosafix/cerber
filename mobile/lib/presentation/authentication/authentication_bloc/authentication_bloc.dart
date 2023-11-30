import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(Unknown()) {
    on<CheckAuthentication>(_onCheckAuthentication);
    on<Authenticate>(_onAuthenticate);
    on<Unauthenticate>(_onUnauthenticate);
  }

  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _tokenKey = 'token';

  void _onCheckAuthentication(CheckAuthentication event, Emitter<AuthenticationState> emit) async {
    final savedToken = await _storage.read(key: _tokenKey);

    if (savedToken == null) {
      return emit(Unauthenticated());
    }

    emit(Authenticated(token: savedToken));
  }

  void _onAuthenticate(Authenticate event, Emitter<AuthenticationState> emit) {
    final token = event.token;

    emit(Authenticated(token: token));

    _storage.write(key: _tokenKey, value: token);
  }

  void _onUnauthenticate(Unauthenticate event, Emitter<AuthenticationState> emit) {
    emit(Unauthenticated());

    _storage.delete(key: _tokenKey);
  }
}
