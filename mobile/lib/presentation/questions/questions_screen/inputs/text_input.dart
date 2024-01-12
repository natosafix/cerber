import 'package:flutter/material.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';

class TextInput extends StatelessWidget {
  TextInput(
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
      readOnly: answer != null,
      decoration: InputDecoration(
        labelText: question.question,
      ),
    );
  }
}
