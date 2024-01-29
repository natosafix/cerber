import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/compound_events_repository/compound_events_repository.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/qr_code_scanner/qr_code_scanner_bloc/qr_code_scanner_bloc.dart';
import 'package:project/presentation/qr_code_scanner/scanner_overlay/scanner_overlay.dart';
import 'package:project/presentation/questions/questions_screen/questions_screen.dart';
import 'package:project/presentation/widgets/flat_app_bar.dart';
import 'package:project/utils/extensions/context_x.dart';
import 'package:project/utils/locator.dart';
import 'package:vibration/vibration.dart';

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
  final scannerController = MobileScannerController(
    detectionTimeoutMs: 500,
  );

  var scanEnabled = true;

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
        event: widget.event,
        compoundEventsRepository: locator<CompoundEventsRepository>(),
      ),
      child: BlocListener<QrCodeScannerBloc, QrCodeScannerState>(
        listener: _stateChanged,
        child: Scaffold(
          appBar: FlatAppBar(
            switchForegroundColorInDarkMode: false,
            actions: [
              IconButton(
                onPressed: () {
                  _addPressed(context);
                },
                icon: const Icon(Icons.add),
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(Icons.history),
              // ),
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
                  onDetect: (capture) => _onDetectQrCode(context, capture),
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

  void _onDetectQrCode(BuildContext context, BarcodeCapture capture) async {
    if (!scanEnabled) return;

    scanEnabled = false;

    context.read<QrCodeScannerBloc>().add(QrCodeScanned(capture: capture));

    final hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator != null && hasVibrator) {
      Vibration.vibrate();
    }
  }

  void _stateChanged(BuildContext context, QrCodeScannerState scannerState) {
    switch (scannerState) {
      case VisitorExists(visitor: final visitor):
        _pushQuestions(visitor, widget.event);
      // Navigator.of(context).push(QuestionsScreen.route(visitor, widget.event));
      case NoSuchVisitorExists():
        _showMessage(L10n.current.failedToFindSuchVisitor);
      // context.showSnackbar(L10n.current.failedToFindSuchVisitor);
      case BoughtTicketOnSpot():
        _showMessage(L10n.current.boughtTicketOnSpot);
      // context.showSnackbar(L10n.current.boughtTicketOnSpot);
      case InitialState():
        break;
      case BadQrCodeFormat():
        _showMessage(L10n.current.badQrCodeFormat);
      // context.showSnackbar(L10n.current.badQrCodeFormat);
      case FailedToReadQrCode():
        _showMessage(L10n.current.failedToReadQrCode);
      // context.showSnackbar(L10n.current.failedToReadQrCode);
    }
  }

  void _addPressed(BuildContext context) {
    _pushQuestions(null, widget.event);
    // Navigator.of(context).push(QuestionsScreen.route(null, widget.event));
  }

  void _showMessage(String message) {
    context.showSnackbar(message);
    scanEnabled = true;
  }

  void _pushQuestions(Visitor? visitor, Event event) async {
    await Navigator.of(context).push(QuestionsScreen.route(visitor, event));
    scanEnabled = true;
  }
}
