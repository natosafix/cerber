import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/qr_code_data.dart';
import 'package:project/domain/models/new_visitor_id.dart';
import 'package:project/utils/cryptor/cryptor.dart';
import 'package:project/utils/cryptor/encrypt_result.dart';
import 'package:project/utils/locator.dart';

class GenerateNewQrCodeUsecase {
  final _cryptor = locator<Cryptor>();

  QrCodeData call({
    required NewVisitorId newVisitorId,
    required Event event,
  }) {
    final EncryptResult encryptResult = _cryptor.encrypt(
      newVisitorId.id,
      event.cryptoKey,
    );

    return QrCodeData(
      iv: encryptResult.iv,
      encryptedVisitorId: encryptResult.encrypted,
    );
  }
}
