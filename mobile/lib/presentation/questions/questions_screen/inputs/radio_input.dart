import 'package:flutter/material.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';

class RadioInput extends StatefulWidget {
  const RadioInput(
    this.question,
    this.answer, {
    super.key,
  });

  final Question question;
  final Answer? answer;

  @override
  State<RadioInput> createState() => _RadioInputState();
}

class _RadioInputState extends State<RadioInput> {
  late String? _selected;

  @override
  void initState() {
    _selected = widget.answer?.answers.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.question.options.map((option) {
        return RadioListTile(
          title: Text(option),
          value: option,
          groupValue: _selected,
          onChanged: widget.answer != null ? _onChanged : null,
        );
      }).toList(),
    );
  }

  void _onChanged(String? value) {
    setState(() {
      _selected = value;
    });
  }
}
