part of 'qr_code_scanner_bloc.dart';

sealed class QrCodeScannerState {}

final class InitialState extends QrCodeScannerState {}

final class FailedToReadQrCode extends QrCodeScannerState {}

final class BadQrCodeFormat extends QrCodeScannerState {}

final class NoSuchVisitorExists extends QrCodeScannerState {}

final class BoughtTicketOnSpot extends QrCodeScannerState {}

final class VisitorExists extends QrCodeScannerState {
  final Visitor visitor;

  VisitorExists(this.visitor);
}
