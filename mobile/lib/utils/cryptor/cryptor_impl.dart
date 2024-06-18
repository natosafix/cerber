import 'package:encrypt/encrypt.dart';
import 'package:project/utils/cryptor/cryptor.dart';
import 'package:project/utils/cryptor/encrypt_result.dart';

class CryptorImpl extends Cryptor {
  @override
  String? decrypt(String encrypted, String key, String iv) {
    final iv_ = IV.fromBase64(iv);
    final encrypted_ = Encrypted.fromBase64(encrypted);

    try {
      return _getEncrypter(key).decrypt(encrypted_, iv: iv_);
    } catch (_) {
      return null;
    }
  }

  @override
  EncryptResult encrypt(String plainValue, String key) {
    final iv = IV.fromLength(16);
    final encrypted = _getEncrypter(key).encrypt(plainValue, iv: iv);

    return EncryptResult(encrypted: encrypted.base64, iv: iv.base64);
  }

  Encrypter _getEncrypter(String key) {
    final key_ = Key.fromBase64(key);
    return Encrypter(AES(key_, mode: AESMode.cbc));
  }
}
