import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeScannerScreen extends StatefulWidget {
  const QrCodeScannerScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const QrCodeScannerScreen(),
      fullscreenDialog: true,
    );
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
          _ScannerOverlay(
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

class _ScannerOverlay extends StatelessWidget {
  _ScannerOverlay({
    required this.scanWindow,
    required this.scanWindowDimension,
  });

  final Rect scanWindow;
  final double scanWindowDimension;

  final overlayColor = Colors.black.withOpacity(0.5);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(overlayColor, BlendMode.srcOut),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
              Positioned.fromRect(
                rect: scanWindow,
                child: Container(
                  height: scanWindowDimension,
                  width: scanWindowDimension,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        _borders(),
      ],
    );
  }

  Widget _borders() {
    const double d = 2;
    final rect = Rect.fromLTRB(
      scanWindow.left - d,
      scanWindow.top - d,
      scanWindow.right + d,
      scanWindow.bottom + d,
    );
    return Positioned.fromRect(
      rect: rect,
      child: CustomPaint(
        foregroundPainter: _BorderPainter(),
      ),
    );
  }
}

class _BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const width = 4.0;
    const radius = 20.0;
    const tRadius = 3 * radius;
    final rect = Rect.fromLTWH(
      width,
      width,
      size.width - 2 * width,
      size.height - 2 * width,
    );
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(radius));
    const clippingRect0 = Rect.fromLTWH(
      0,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect1 = Rect.fromLTWH(
      size.width - tRadius,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect2 = Rect.fromLTWH(
      0,
      size.height - tRadius,
      tRadius,
      tRadius,
    );
    final clippingRect3 = Rect.fromLTWH(
      size.width - tRadius,
      size.height - tRadius,
      tRadius,
      tRadius,
    );

    final path = Path()
      ..addRect(clippingRect0)
      ..addRect(clippingRect1)
      ..addRect(clippingRect2)
      ..addRect(clippingRect3);

    canvas.clipPath(path);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = width,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
