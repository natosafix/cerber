import 'package:flutter/material.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/presentation/questions/questions_screen/questions_screen.dart';

class MultiLineTextInput extends StatelessWidget {
  MultiLineTextInput(
    this.question,
    this.answer, {
    super.key,
  }) : _controller = TextEditingController(text: answer?.answers.first);

  final Question question;
  final Answer? answer;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: QuestionsScreen.midInputsPadding * 2),
      child: TextField(
        controller: _controller,
        readOnly: answer != null,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: question.question,
        ),
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
    );
  }
}
