import 'package:encrypt/encrypt.dart';
import 'package:project/utils/cryptor/cryptor.dart';
import 'package:project/utils/cryptor/encrypt_result.dart';

class CryptorImpl extends Cryptor {
  Key _getKey(String key) => Key.fromBase64(key);

  Encrypter _getEncrypter(Key key) => Encrypter(AES(key, mode: AESMode.cbc));

  @override
  String? decrypt(String encrypted, String key, String iv) {
    final _key = _getKey(key);
    final _iv = IV.fromBase64(iv);
    final _encrypted = Encrypted.fromBase64(encrypted);

    try {
      return _getEncrypter(_key).decrypt(_encrypted, iv: _iv);
    } catch (_) {
      return null;
    }
  }

  @override
  EncryptResult encrypt(String plainValue, String key) {
    final _key = _getKey(key);
    final iv = IV.fromLength(16);
    final encrypted = _getEncrypter(_key).encrypt(plainValue, iv: iv);

    return EncryptResult(encrypted: encrypted.base64, iv: iv.base64);
  }
}
