import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({
    required this.qrCodeData,
    super.key,
  });

  final String qrCodeData;

  static Route route(String qrCodeData) {
    return MaterialPageRoute(builder: (context) => QrCodeScreen(qrCodeData: qrCodeData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QrImageView(
        data: qrCodeData,
        size: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }
}
