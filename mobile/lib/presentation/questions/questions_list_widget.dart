import 'package:flutter/material.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/question_type.dart';
import 'package:project/domain/models/ticket.dart';
import 'package:project/presentation/questions/inputs/checkbox_input.dart';
import 'package:project/presentation/questions/inputs/multiline_text_input.dart';
import 'package:project/presentation/questions/inputs/radio_input.dart';
import 'package:project/presentation/questions/inputs/text_input.dart';

class QuestionsListWidget extends StatelessWidget {
  const QuestionsListWidget({
    super.key,
    required this.questionsMap,
    this.startChildren,
    this.endChildren,
    this.onTicketChanged,
    this.onTextChanged,
    this.onRadioChanged,
    this.onCheckboxChanged,
  });

  final Map<Question, Answer> questionsMap;
  final List<Widget>? startChildren;
  final List<Widget>? endChildren;

  final ValueChanged<Ticket>? onTicketChanged;
  final void Function(Question, String)? onTextChanged;
  final void Function(Question, String)? onRadioChanged;
  final void Function(Question, String, bool)? onCheckboxChanged;

  static const double _midInputsPadding = 8;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (startChildren != null && startChildren!.isNotEmpty) ...startChildren!,
          for (final (question, answer) in questionsMap.entries.map((e) => (e.key, e.value)))
            Padding(
              padding: const EdgeInsets.only(top: _midInputsPadding),
              child: switch (question.questionType) {
                QuestionType.oneLineText => TextInput(
                    label: question.question,
                    initialValue: answer.answers.first,
                    onChanged:
                        onTextChanged == null ? null : (value) => onTextChanged!(question, value),
                  ),
                QuestionType.multiLineText => Padding(
                    padding: const EdgeInsets.symmetric(vertical: _midInputsPadding + 8),
                    child: MultilineTextInput(
                      label: question.question,
                      initialValue: answer.answers.first,
                      onChanged:
                          onTextChanged == null ? null : (value) => onTextChanged!(question, value),
                    ),
                  ),
                QuestionType.radio => RadioInput(
                    label: question.question,
                    options: question.options,
                    selectedOption: null,
                    onChanged:
                        onRadioChanged == null ? null : (value) => onRadioChanged!(question, value),
                  ),
                QuestionType.checkbox => CheckboxInput(
                    label: question.question,
                    options: [
                      for (final option in question.options)
                        (option, answer.answers.contains(option)),
                    ],
                    onChanged: onCheckboxChanged == null
                        ? null
                        : (option, isSelected) => onCheckboxChanged!(question, option, isSelected),
                  )
              },
            ),
          if (endChildren != null && endChildren!.isNotEmpty) ...endChildren!,
        ],
      ),
    );
  }
}
