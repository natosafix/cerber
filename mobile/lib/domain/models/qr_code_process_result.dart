sealed class QrCodeProcessResult {}

final class QrCodeInvalid extends QrCodeProcessResult {}

final class DecryptionSuccess extends QrCodeProcessResult {
  DecryptionSuccess(this.visitorId);

  final String visitorId;
}

final class DecryptionFail extends QrCodeProcessResult {}
