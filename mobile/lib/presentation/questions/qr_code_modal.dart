import 'package:flutter/material.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/widgets/flat_app_bar.dart';
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
      appBar: FlatAppBar(
        title: Text(L10n.current.yourQrCode),
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
