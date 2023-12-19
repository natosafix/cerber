import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/presentation/qr_code_scanner/scanner_overlay/scanner_overlay.dart';

class QrCodeScannerScreen extends StatefulWidget {
  const QrCodeScannerScreen({required this.event, super.key});

  final Event event;

  static Route route(Event event) {
    return MaterialPageRoute(builder: (context) => QrCodeScannerScreen(event: event));
  }
  
  @override
  State<QrCodeScannerScreen> createState() => _QrCodeScannerScreenState();
}

class _QrCodeScannerScreenState extends State<QrCodeScannerScreen> {
  final scannerController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final scanWindowDimension = screenSize.width * 0.6;
    final scanWindow = Rect.fromCircle(
      center: Offset(screenSize.width * 0.5, screenSize.height * 0.4),
      radius: scanWindowDimension / 2,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      floatingActionButton: ValueListenableBuilder(
        valueListenable: scannerController.torchState,
        builder: (context, state, child) {
          final icon = state == TorchState.on ? Icons.flash_off : Icons.flash_on;
          final bgColor = state == TorchState.on ? Colors.yellow : Colors.grey;
          return CircleAvatar(
            backgroundColor: bgColor,
            radius: 30,
            child: IconButton(
              icon: Icon(icon),
              color: Colors.black,
              onPressed: scannerController.toggleTorch,
            ),
          );
        },
      ),
      body: Stack(
        children: [
          MobileScanner(
            scanWindow: scanWindow,
            controller: scannerController,
            onDetect: _onDetect,
          ),
          ScannerOverlay(
            scanWindow: scanWindow,
            scanWindowDimension: scanWindowDimension,
          ),
        ],
      ),
    );
  }

  void _onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      debugPrint('Barcode found! ${barcode.rawValue}');
    }
  }
}
