import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/qr_code_data.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/compound_events_repository/compound_events_repository.dart';
import 'package:project/domain/repositories/compound_events_repository/qr_code_process_result.dart';

part 'qr_code_scanner_event.dart';
part 'qr_code_scanner_state.dart';

class QrCodeScannerBloc extends Bloc<QrCodeScannerEvent, QrCodeScannerState> {
  QrCodeScannerBloc({
    required Event event,
    required CompoundEventsRepository compoundEventsRepository,
  })  : _event = event,
        _compoundEventsRepository = compoundEventsRepository,
        super(InitialState()) {
    on<QrCodeScanned>(_onQrCodeScanned);
  }

  final CompoundEventsRepository _compoundEventsRepository;
  final Event _event;

  void _onQrCodeScanned(QrCodeScanned event, Emitter<QrCodeScannerState> emit) async {
    final value = event.capture.barcodes.first.rawValue;

    if (value == null) {
      return emit(FailedToReadQrCode());
    }

    final qrCodeData = QrCodeData.fromString(value);

    if (qrCodeData == null) {
      return emit(BadQrCodeFormat());
    }

    final qrCodeProcessResult = await _compoundEventsRepository.processQrCode(qrCodeData, _event);

    switch (qrCodeProcessResult) {
      case VisitorFound(visitor: final visitor):
        emit(VisitorExists(visitor));
      case VisitorNotFound():
        emit(NoSuchVisitorExists());
      case VisitorIdValidButNotFound():
        emit(BoughtTicketOnSpot());
    }
  }
}
