import 'package:project/utils/cryptor/encrypt_result.dart';

abstract class Cryptor {
  EncryptResult encrypt(String plainValue, String key);

  String? decrypt(String encrypted, String key, String iv);
}
