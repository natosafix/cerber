import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/qr_code_scanner/qr_code_scanner_bloc/qr_code_scanner_bloc.dart';
import 'package:project/presentation/qr_code_scanner/scanner_overlay/scanner_overlay.dart';
import 'package:project/presentation/questions/questions_bloc/impls/questions_filler_bloc.dart';
import 'package:project/presentation/questions/questions_bloc/impls/questions_viewer_bloc.dart';
import 'package:project/presentation/questions/questions_screen/questions_screen.dart';
import 'package:project/presentation/widgets/flat_app_bar.dart';
import 'package:project/utils/extensions/context_x.dart';
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

  late final bool hasVibrator;

  @override
  void initState() {
    _checkVibrator();
    super.initState();
  }

  void _checkVibrator() async {
    hasVibrator = await Vibration.hasVibrator() ?? false;
  }

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

    if (hasVibrator) {
      Vibration.vibrate();
    }
  }

  void _stateChanged(BuildContext context, QrCodeScannerState scannerState) {
    switch (scannerState) {
      case VisitorExists(visitor: final visitor):
        final screen = QuestionsScreen(
          questionsBloc: QuestionsViewerBloc(
            event: widget.event,
            questionsMap: visitor.questionsMap,
            tickets: [visitor.ticket],
            selectedTicket: visitor.ticket,
          ),
          title: L10n.current.visitorsInformation,
          ticketLabel: L10n.current.ticket,
          questionsLabel: L10n.current.form,
          finishButtonText: null,
          allowEdit: false,
          postFrameCallback: (context) {
            if (visitor.qrCodeScannedTime == null) return;
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(L10n.current.qrCodeAlreadyBeenScanned),
                  actions: [
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                );
              },
            );
          },
        );
        _pushQuestionsScreen(screen);
      case NoSuchVisitorExists():
        _showMessage(L10n.current.failedToFindSuchVisitor);
      case BoughtTicketOnSpot():
        _showMessage(L10n.current.boughtTicketOnSpot);
      case InitialState():
        break;
      case BadQrCodeFormat():
        _showMessage(L10n.current.badQrCodeFormat);
      case FailedToReadQrCode():
        _showMessage(L10n.current.failedToReadQrCode);
    }
  }

  void _addPressed(BuildContext context) {
    final screen = QuestionsScreen(
      questionsBloc: QuestionsFillerBloc(
        event: widget.event,
      ),
      title: L10n.current.addNewVisitor,
      ticketLabel: L10n.current.chooseTicket,
      questionsLabel: L10n.current.fillTheForm,
      finishButtonText: L10n.current.save,
      allowEdit: true,
    );
    _pushQuestionsScreen(screen);
  }

  void _pushQuestionsScreen(QuestionsScreen questionsScreen) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => questionsScreen,
      ),
    );
    scanEnabled = true;
  }

  void _showMessage(String message) {
    context.showSnackbar(message);
    scanEnabled = true;
  }
}
