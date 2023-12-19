import 'package:flutter/material.dart';
import 'package:project/presentation/qr_code_scanner/scanner_overlay/border_painter.dart';

class ScannerOverlay extends StatelessWidget {
  ScannerOverlay({
    required this.scanWindow,
    required this.scanWindowDimension,
    super.key,
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
        foregroundPainter: BorderPainter(),
      ),
    );
  }
}
