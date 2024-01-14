import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/repositories/compound_events_repository/compound_events_repository.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/qr_code_scanner/qr_code_scanner_bloc/qr_code_scanner_bloc.dart';
import 'package:project/presentation/qr_code_scanner/scanner_overlay/scanner_overlay.dart';
import 'package:project/presentation/questions/questions_screen/questions_screen.dart';
import 'package:project/utils/extensions/context_x.dart';
import 'package:project/utils/locator.dart';

class QrCodeScannerScreen extends StatelessWidget {
  QrCodeScannerScreen({required this.event, super.key});

  final Event event;

  static Route route(Event event) {
    return MaterialPageRoute(builder: (context) => QrCodeScannerScreen(event: event));
  }

  final scannerController = MobileScannerController(
    detectionTimeoutMs: 1500,
  );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final scanWindowPosition = Offset(screenSize.width * 0.5, screenSize.height * 0.4);
    final scanWindowDimension = screenSize.width * 0.6;
    final scanWindow = Rect.fromCircle(
      center: scanWindowPosition,
      radius: scanWindowDimension / 2,
    );

    return BlocProvider(
      create: (context) => QrCodeScannerBloc(
        event: event,
        compoundEventsRepository: locator<CompoundEventsRepository>(),
      ),
      child: BlocListener<QrCodeScannerBloc, QrCodeScannerState>(
        listener: _stateChanged,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                onPressed: () {
                  _addPressed(context);
                },
                icon: const Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {}, //TODO
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
              Builder(builder: (context) {
                return MobileScanner(
                  scanWindow: scanWindow,
                  controller: scannerController,
                  onDetect: (capture) {
                    context.read<QrCodeScannerBloc>().add(QrCodeScanned(capture: capture));
                  },
                );
              }),
              ScannerOverlay(
                scanWindow: scanWindow,
                scanWindowDimension: scanWindowDimension,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _stateChanged(BuildContext context, QrCodeScannerState scannerState) {
    switch (scannerState) {
      case VisitorExists(visitor: final visitor):
        Navigator.of(context).push(QuestionsScreen.route(visitor, event));
      case NoSuchVisitorExists():
        context.showSnackbar(L10n.current.failedToFindSuchVisitor);
      case BoughtTicketOnSpot():
        context.showSnackbar(L10n.current.boughtTicketOnSpot);
      case InitialState():
        break;
      case BadQrCodeFormat():
        context.showSnackbar(L10n.current.badQrCodeFormat);
      case FailedToReadQrCode():
        context.showSnackbar(L10n.current.failedToReadQrCode);
    }
  }

  void _addPressed(BuildContext context) {
    Navigator.of(context).push(QuestionsScreen.route(null, event));
  }
}
