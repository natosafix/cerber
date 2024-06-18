import 'package:flutter/material.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/ticket.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/questions/questions_list_widget.dart';
import 'package:project/presentation/questions/questions_screen_base.dart';
import 'package:project/presentation/questions/inputs/ticket_selector.dart';

class QuestionsViewerScreen extends StatelessWidget {
  const QuestionsViewerScreen({
    super.key,
    required this.questionsMap,
    required this.selectedTicket,
    required this.isQrCodeAlreadyScanned,
  });

  final Map<Question, Answer> questionsMap;
  final Ticket selectedTicket;
  final bool isQrCodeAlreadyScanned;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _postFrameCallback(context));

    return QuestionsScreenBase(
      title: L10n.current.visitorsInformation,
      child: Builder(
        builder: (context) {
          if (questionsMap.isEmpty) {
            return Center(
              child: Text(L10n.current.questionsEmpty),
            );
          }

          return QuestionsListWidget(
            questionsMap: questionsMap,
            startChildren: [
              Text(L10n.current.ticket),
              TicketSelector(tickets: [selectedTicket], selectedTicket: selectedTicket),
              const SizedBox(height: 10),
              Text(L10n.current.form),
            ],
          );
        },
      ),
    );
  }

  void _postFrameCallback(BuildContext context) {
    if (isQrCodeAlreadyScanned) {
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
    }
  }
}
