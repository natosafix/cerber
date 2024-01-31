class QrCodeData {
  final String iv;
  final String encryptedVisitorId;

  QrCodeData({
    required this.iv,
    required this.encryptedVisitorId,
  });

  static const _separator = ';';

  // qrcode format: 'iv;encryptedVisitorId'

  static QrCodeData? fromString(String value) {
    final split = value.split(_separator);
    if (split.length < 2) return null;

    return QrCodeData(
      iv: split[0],
      encryptedVisitorId: split[1],
    );
  }

  @override
  String toString() {
    return [
      iv,
      encryptedVisitorId,
    ].join(_separator);
  }
}
