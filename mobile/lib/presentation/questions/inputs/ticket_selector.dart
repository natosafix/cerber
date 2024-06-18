import 'package:flutter/material.dart';
import 'package:project/domain/models/ticket.dart';

class TicketSelector extends StatefulWidget {
  const TicketSelector({
    super.key,
    required this.tickets,
    required this.selectedTicket,
    this.onChanged,
  });

  final List<Ticket> tickets;
  final Ticket? selectedTicket;
  final ValueChanged<Ticket>? onChanged;

  @override
  State<TicketSelector> createState() => _TicketSelectorState();
}

class _TicketSelectorState extends State<TicketSelector> {
  late Ticket? _selected;

  @override
  void initState() {
    _selected = widget.selectedTicket;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final ticket in widget.tickets)
          RadioListTile(
            title: Text(ticket.name),
            subtitle: Text("${ticket.price} ₽"),
            value: ticket,
            groupValue: _selected,
            onChanged: (ticket) => _onChanged(ticket!),
            contentPadding: EdgeInsets.zero,
          ),
      ],
    );
  }

  void _onChanged(Ticket ticket) {
    if (widget.onChanged == null) return;

    widget.onChanged!(ticket);

    setState(() {
      _selected = ticket;
    });
  }
}
