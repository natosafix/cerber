part of 'qr_code_scanner_bloc.dart';

sealed class QrCodeScannerState {}

final class InitialState extends QrCodeScannerState {}

final class FailedToReadQrCode extends QrCodeScannerState {}

final class NoSuchVisitorFound extends QrCodeScannerState {}

final class BoughtTicketOnSpot extends QrCodeScannerState {}

final class VisitorFound extends QrCodeScannerState {
  final Visitor visitor;

  VisitorFound(this.visitor);
}
