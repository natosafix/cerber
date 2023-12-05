import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final class SecureStorage {
  SecureStorage._();

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static FlutterSecureStorage get instance => _storage;
}
