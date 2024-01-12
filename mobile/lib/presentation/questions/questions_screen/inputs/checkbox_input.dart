import 'package:flutter/material.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';

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
    return Column(
      children: widget.question.options.map((option) {
        return CheckboxListTile(
          title: Text(option),
          value: _selected[option],
          onChanged: widget.answer != null ? (value) => _onChanged(option, value) : null,
          controlAffinity: ListTileControlAffinity.leading,
        );
      }).toList(),
    );
  }

  void _onChanged(String option, bool? value) {
    setState(() {
      _selected[option] = value!;
    });
  }
}
