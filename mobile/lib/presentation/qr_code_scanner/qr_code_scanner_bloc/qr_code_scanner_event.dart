part of 'qr_code_scanner_bloc.dart';

sealed class QrCodeScannerEvent {}

final class QrCodeScanned extends QrCodeScannerEvent {
  final BarcodeCapture capture;

  QrCodeScanned({required this.capture});
}
