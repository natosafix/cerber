import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/question_type.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/questions/questions_bloc/questions_bloc_base.dart';
import 'package:project/presentation/questions/questions_screen/inputs/checkbox_input.dart';
import 'package:project/presentation/questions/questions_screen/inputs/multi_line_text_input.dart';
import 'package:project/presentation/questions/questions_screen/inputs/radio_input.dart';
import 'package:project/presentation/questions/questions_screen/inputs/text_input.dart';
import 'package:project/presentation/questions/questions_screen/ticket_selector.dart';
import 'package:project/presentation/widgets/flat_app_bar.dart';
import 'package:project/presentation/widgets/full_width_button.dart';
import 'package:project/utils/extensions/context_x.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({
    required this.questionsBloc,
    required this.title,
    required this.ticketLabel,
    required this.questionsLabel,
    required this.finishButtonText,
    required this.allowEdit,
    this.postFrameCallback,
    super.key,
  });

  final QuestionsBlocBase questionsBloc;
  final String title;
  final String ticketLabel;
  final String questionsLabel;
  final String? finishButtonText;
  final bool allowEdit;
  final void Function(BuildContext context)? postFrameCallback;

  static const double _midInputsPadding = 8;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _postFrameCallback(context));

    return BlocProvider.value(
      value: questionsBloc,
      child: Scaffold(
        appBar: FlatAppBar(
          title: Text(title),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocConsumer<QuestionsBlocBase, QuestionsState>(
            listener: _onListen,
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.questionsMap.isEmpty) {
                return Center(
                  child: Text(L10n.current.questionsEmpty),
                );
              }

              return ListView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                children: [
                  const SizedBox(height: _midInputsPadding),
                  Text(ticketLabel),
                  TicketSelector(tickets: state.tickets, selectedTicket: state.selectedTicket),
                  const SizedBox(height: _midInputsPadding),
                  Text(questionsLabel),
                  for (final (question, answer) in state.questionsMap.entries.map((e) => (e.key, e.value)))
                    Padding(
                      padding: const EdgeInsets.only(top: _midInputsPadding),
                      child: switch (question.questionType) {
                        QuestionType.oneLineText => TextInput(question, answer, allowEdit),
                        QuestionType.multiLineText => Padding(
                            padding: const EdgeInsets.only(top: _midInputsPadding * 2, bottom: _midInputsPadding),
                            child: MultiLineTextInput(question, answer, allowEdit),
                          ),
                        QuestionType.radio => RadioInput(question, answer, allowEdit),
                        QuestionType.checkbox => CheckboxInput(question, answer, allowEdit),
                      },
                    ),
                  if (finishButtonText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: _midInputsPadding, bottom: 20),
                      child: FullWidthButton(
                        onPressed: () => context.read<QuestionsBlocBase>().add(FinishPressed()),
                        child: Text(finishButtonText!),
                      ),
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _onListen(BuildContext context, QuestionsState state) async {
    if (state.messageToShow != null) {
      context.showSnackbar(state.messageToShow!);
    }

    if (state.modalToShow != null) {
      await showModalBottomSheet(
        context: context,
        builder: (context) => state.modalToShow!,
      );

      if (context.mounted) {
        state.onModalClosed!(context);
      }
    }
  }

  void _postFrameCallback(BuildContext context) {
    if (postFrameCallback != null) {
      postFrameCallback!(context);
    }
  }
}
