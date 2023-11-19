import 'package:flutter/material.dart';

import '../../domain/models/event.dart';
import '../../domain/models/visitor.dart';
import '../../utils/theme_util.dart';
import 'qr_code_scanner_screen.dart';

class VisitorsListScreen extends StatefulWidget {
  const VisitorsListScreen(this.event, {super.key});

  final Event event;

  static Route route(Event event) {
    return MaterialPageRoute(builder: (context) => VisitorsListScreen(event));
  }

  @override
  State<VisitorsListScreen> createState() => _VisitorsListScreenState();
}

class _VisitorsListScreenState extends State<VisitorsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: Visitor.mock.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(Visitor.mock[index].name),
          );
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ThemeUtil.isLight(context) ? Colors.black : Colors.white,
        elevation: 0,
        title: const Text("Посетители"),
        actions: [
          TextButton.icon(onPressed: () {}, icon: const Icon(Icons.add), label: const Text("Добавить")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanQrCodePressed,
        tooltip: "Сканировать QR-код посетителя",
        child: const Icon(Icons.qr_code_2),
      ),
    );
  }

  void _scanQrCodePressed() {
    Navigator.of(context).push(QrCodeScannerScreen.route());
  }
}
