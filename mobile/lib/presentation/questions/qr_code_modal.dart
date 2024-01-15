import 'package:flutter/material.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/utils/extensions/context_x.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeModal extends StatelessWidget {
  const QrCodeModal({
    required this.qrCodeData,
    super.key,
  });

  final String qrCodeData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.current.yourQrCode),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: context.appBarForegroundColor(),
      ),
      body: Center(
        child: QrImageView(
          data: qrCodeData,
          backgroundColor: Colors.white,
          size: MediaQuery.of(context).size.width * 0.8,
        ),
      ),
    );
  }
}
