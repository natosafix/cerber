import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/qr_code_data.dart';
import 'package:project/domain/models/qr_code_process_result.dart';
import 'package:project/domain/repositories/local_events_repository.dart';
import 'package:project/utils/cryptor/cryptor.dart';
import 'package:project/utils/locator.dart';

class ProcessQrCodeUsecase {
  final _cryptor = locator<Cryptor>();
  final _localEventsRepository = locator<LocalEventsRepository>();

  QrCodeProcessResult call({
    required String value,
    required Event event,
  }) {
    final QrCodeData? qrCodeData = QrCodeData.fromString(value);

    if (qrCodeData == null) {
      return QrCodeInvalid();
    }

    final String? visitorIdDecrypted = _cryptor.decrypt(
      qrCodeData.encryptedVisitorId,
      event.cryptoKey,
      qrCodeData.iv,
    );

    if (visitorIdDecrypted == null) {
      return DecryptionFail();
    }

    _localEventsRepository.setVisitorQrCodeScanned(visitorIdDecrypted, event.id);

    return DecryptionSuccess(visitorIdDecrypted);
  }
}
