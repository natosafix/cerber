import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _tokenKey = 'token';

  AuthenticationBloc() : super(Unknown()) {
    on<CheckAuthentication>(_onCheckAuthentication);
    on<Authenticate>(_onAuthenticate);
    on<Unauthenticate>(_onUnauthenticate);
  }

  void _onCheckAuthentication(CheckAuthentication event, Emitter<AuthenticationState> emit) async {
    final savedToken = await _storage.read(key: _tokenKey);

    if (savedToken == null) {
      return emit(Unauthenticated());
    }

    emit(Authenticated(token: savedToken));
  }

  void _onAuthenticate(Authenticate event, Emitter<AuthenticationState> emit) async {
    final token = event.token;

    await _storage.write(key: _tokenKey, value: token);

    emit(Authenticated(token: token));
  }

  void _onUnauthenticate(Unauthenticate event, Emitter<AuthenticationState> emit) async {
    await _storage.delete(key: _tokenKey);

    emit(Unauthenticated());
  }
}
