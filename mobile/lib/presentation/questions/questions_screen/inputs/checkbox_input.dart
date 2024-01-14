import 'package:flutter/material.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/presentation/questions/questions_screen/questions_screen.dart';

class CheckboxInput extends StatefulWidget {
  const CheckboxInput(
    this.question,
    this.answer, {
    super.key,
  });

  final Question question;
  final Answer? answer;

  @override
  State<CheckboxInput> createState() => _CheckboxInputState();
}

class _CheckboxInputState extends State<CheckboxInput> {
  late final Map<String, bool> _selected;

  @override
  void initState() {
    _selected = {
      for (final option in widget.question.options)
        option: widget.answer != null ? widget.answer!.answers.contains(option) : false
    };
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
            return CheckboxListTile(
              title: Text(option),
              value: _selected[option],
              onChanged: widget.answer == null ? (value) => _onChanged(option, value) : (_) {},
              controlAffinity: ListTileControlAffinity.leading,
            );
          }),
        ],
      ),
    );
  }

  void _onChanged(String option, bool? value) {
    setState(() {
      _selected[option] = value!;
    });
  }
}
