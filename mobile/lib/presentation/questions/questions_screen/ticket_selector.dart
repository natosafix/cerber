import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/ticket.dart';
import 'package:project/presentation/questions/questions_bloc/questions_bloc_base.dart';

class TicketSelector extends StatelessWidget {
  const TicketSelector({
    required this.tickets,
    required this.selectedTicket,
    super.key,
  });

  final List<Ticket> tickets;
  final Ticket? selectedTicket;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final ticket in tickets)
          RadioListTile(
            title: Text(ticket.name),
            subtitle: Text("${ticket.price} ₽"),
            value: ticket,
            groupValue: selectedTicket,
            onChanged: (ticket) => _onChanged(context, ticket!),
            contentPadding: EdgeInsets.zero,
          ),
      ],
    );
  }

  void _onChanged(BuildContext context, Ticket ticket) {
    context.read<QuestionsBlocBase>().add(TicketChanged(ticket: ticket));
  }
}
