import 'package:flutter/material.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';

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
    return TextField(
      controller: _controller,
      enabled: answer == null,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: question.question,
      ),
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.multiline,
      maxLines: 2,
    );
  }
}
