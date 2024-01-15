import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/presentation/questions/questions_bloc/questions_bloc.dart';

class TextInput extends StatelessWidget {
  const TextInput(
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
    return TextFormField(
      initialValue: answer.answers.first,
      readOnly: !filling,
      decoration: InputDecoration(
        labelText: question.question,
      ),
      onChanged: (value) => _onChanged(context, value),
    );
  }

  void _onChanged(BuildContext context, String value) {
    context.read<QuestionsBloc>().add(TextChanged(question: question, newValue: value));
  }
}
