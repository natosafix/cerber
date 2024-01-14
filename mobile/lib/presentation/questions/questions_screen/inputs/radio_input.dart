import 'package:flutter/material.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/presentation/questions/questions_screen/questions_screen.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: QuestionsScreen.midInputsPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question.question,
            style: TextStyle(color: Colors.grey.shade600),
          ),
          ...widget.question.options.map((option) {
            return RadioListTile(
              title: Text(option),
              value: option,
              groupValue: _selected,
              onChanged: widget.answer == null ? _onChanged : (_) {},
            );
          }),
        ],
      ),
    );
  }

  void _onChanged(String? value) {
    setState(() {
      _selected = value;
    });
  }
}
