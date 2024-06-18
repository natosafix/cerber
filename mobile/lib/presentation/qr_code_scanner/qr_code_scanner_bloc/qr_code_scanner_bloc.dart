import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/models/qr_code_process_result.dart';
import 'package:project/domain/usecases/find_visitor_usecase.dart';
import 'package:project/domain/usecases/process_qr_code_usecase.dart';
import 'package:project/utils/locator.dart';

part 'qr_code_scanner_event.dart';
part 'qr_code_scanner_state.dart';

class QrCodeScannerBloc extends Bloc<QrCodeScannerEvent, QrCodeScannerState> {
  QrCodeScannerBloc({
    required Event event,
  })  : _event = event,
        super(InitialState()) {
    on<QrCodeScanned>(_onQrCodeScanned);
  }

  final Event _event;

  final _processQrCodeUsecase = locator<ProcessQrCodeUsecase>();
  final _findVisitorUsecase = locator<FindVisitorUsecase>();

  void _onQrCodeScanned(QrCodeScanned event, Emitter<QrCodeScannerState> emit) async {
    final String? value = event.capture.barcodes.first.rawValue;

    if (value == null) {
      return emit(FailedToReadQrCode());
    }

    final QrCodeProcessResult qrCodeProcessResult = _processQrCodeUsecase(
      value: value,
      event: _event,
    );

    switch (qrCodeProcessResult) {
      case QrCodeInvalid():
        emit(BadQrCodeFormat());

      case DecryptionFail():
        emit(NoSuchVisitorExists());

      case DecryptionSuccess(visitorId: final visitorId):
        final Visitor? visitor = await _findVisitorUsecase(
          visitorId: visitorId,
          eventId: _event.id,
        );

        if (visitor == null) {
          emit(BoughtTicketOnSpot());
          return;
        }

        emit(VisitorExists(visitor));
    }
  }
}
