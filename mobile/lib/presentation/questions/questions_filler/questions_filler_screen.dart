import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/questions/questions_filler/qr_code_modal.dart';
import 'package:project/presentation/questions/questions_filler/questions_filler_bloc/questions_filler_bloc.dart';
import 'package:project/presentation/questions/questions_list_widget.dart';
import 'package:project/presentation/questions/questions_screen_base.dart';
import 'package:project/presentation/questions/inputs/ticket_selector.dart';
import 'package:project/presentation/widgets/full_width_button.dart';
import 'package:project/utils/extensions/context_x.dart';

import 'questions_filler_bloc/questions_loading_status.dart';

class QuestionsFillerScreen extends StatelessWidget {
  const QuestionsFillerScreen({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return QuestionsScreenBase(
      title: L10n.current.addNewVisitor,
      child: BlocProvider(
        create: (context) => QuestionsFillerBloc(event: event),
        child: BlocConsumer<QuestionsFillerBloc, QuestionsFillerState>(
          listener: _onListen,
          builder: (context, state) {
            switch (state.questionsLoadingStatus) {
              case QuestionsLoadingStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case QuestionsLoadingStatus.failure:
                return Center(
                  child: Text(L10n.current.somethingWentWrong),
                );
              case QuestionsLoadingStatus.success:
                if (state.questionsMap.isEmpty) {
                  return Center(
                    child: Text(L10n.current.questionsEmpty),
                  );
                }

                return QuestionsListWidget(
                  questionsMap: state.questionsMap,
                  onTicketChanged: (ticket) {
                    context.read<QuestionsFillerBloc>().add(TicketChanged(ticket));
                  },
                  onTextChanged: (question, text) {
                    context.read<QuestionsFillerBloc>().add(TextChanged(question: question, newValue: text));
                  },
                  onRadioChanged: (question, value) {
                    context.read<QuestionsFillerBloc>().add(RadioChanged(question: question, selectedValue: value));
                  },
                  onCheckboxChanged: (question, value, isSelected) {
                    context.read<QuestionsFillerBloc>().add(CheckboxChanged(
                          question: question,
                          value: value,
                          isSelected: isSelected,
                        ));
                  },
                  startChildren: [
                    Text(L10n.current.chooseTicket),
                    TicketSelector(
                      tickets: state.tickets,
                      selectedTicket: state.selectedTicket,
                      onChanged: (ticket) {
                        context.read<QuestionsFillerBloc>().add(TicketChanged(ticket));
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(L10n.current.fillTheForm),
                  ],
                  endChildren: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: FullWidthButton(
                        onPressed: () => context.read<QuestionsFillerBloc>().add(FinishPressed()),
                        child: Text(L10n.current.save),
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }

  void _onListen(BuildContext context, QuestionsFillerState state) async {
    if (state.messageToShow != null) {
      context.showSnackbar(state.messageToShow!);
    }

    if (state.generatedQrCodeData != null) {
      await showModalBottomSheet(
        context: context,
        builder: (context) => QrCodeModal(qrCodeData: state.generatedQrCodeData.toString()),
      );

      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
