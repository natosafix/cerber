import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/compound_events_repository/compound_events_repository.dart';

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

    // before trying to find the visitor we need to decrypt the 'value' to retreive this visitor's id
    // ...but we havent decided on the implementation yet :(

    // perform decryption here
    final visitorId = value;
    const DECRYPTION_SUCCESSFUL = true;

    if (!DECRYPTION_SUCCESSFUL) {
      return emit(NoSuchVisitorFound());
    }

    final visitor = await _compoundEventsRepository.findVisitor(visitorId, _event.id);

    if (visitor == null) {
      // decryption is successful but we couldnt find this visitor in any repo
      // which means they bought a ticket on spot
      return emit(BoughtTicketOnSpot());
    }

    return emit(VisitorFound(visitor));
  }
}
