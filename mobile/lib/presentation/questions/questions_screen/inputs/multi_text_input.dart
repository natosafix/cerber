import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/presentation/questions/questions_bloc/questions_bloc.dart';
import 'package:project/presentation/questions/questions_screen/questions_screen.dart';

class MultiLineTextInput extends StatelessWidget {
  const MultiLineTextInput(
    this.question,
    this.answer,
    this.filling, {
    super.key,
  });

  final Question question;
  final Answer answer;
  final bool filling;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: QuestionsScreen.midInputsPadding * 2),
      child: TextFormField(
        initialValue: answer.answers.first,
        readOnly: !filling,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: question.question,
        ),
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (value) => _onChanged(context, value),
      ),
    );
  }

  void _onChanged(BuildContext context, String value) {
    context.read<QuestionsBloc>().add(TextChanged(question: question, newValue: value));
  }
}
