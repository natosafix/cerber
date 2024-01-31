import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/presentation/questions/questions_bloc/questions_bloc_base.dart';

class MultiLineTextInput extends StatelessWidget {
  const MultiLineTextInput(
    this.question,
    this.answer,
    this.allowEdit, {
    super.key,
  });

  final Question question;
  final Answer answer;
  final bool allowEdit;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: answer.answers.first,
      readOnly: !allowEdit,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: question.question,
      ),
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      onChanged: (value) => _onChanged(context, value),
    );
  }

  void _onChanged(BuildContext context, String value) {
    context.read<QuestionsBlocBase>().add(TextChanged(question: question, newValue: value));
  }
}
