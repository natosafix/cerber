import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/ticket.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/questions/questions_bloc/questions_bloc.dart';
import 'package:project/presentation/questions/questions_screen/questions_screen.dart';

class TicketSelector extends StatefulWidget {
  const TicketSelector(
    this.tickets,
    this.selectedTicket, {
    super.key,
  });

  final List<Ticket> tickets;
  final Ticket? selectedTicket;

  @override
  State<TicketSelector> createState() => _TicketSelectorState();
}

class _TicketSelectorState extends State<TicketSelector> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: QuestionsScreen.midInputsPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(L10n.current.chooseTicket),
          ...widget.tickets.map((ticket) {
            return RadioListTile(
              title: Text(ticket.name),
              subtitle: Text("${ticket.price} ₽"),
              value: ticket,
              groupValue: widget.selectedTicket,
              onChanged: (t) => _onChanged(context, t!),
              contentPadding: EdgeInsets.zero,
            );
          }),
        ],
      ),
    );
  }

  void _onChanged(BuildContext context, Ticket ticket) {
    context.read<QuestionsBloc>().add(TicketChanged(ticket: ticket));
  }
}
