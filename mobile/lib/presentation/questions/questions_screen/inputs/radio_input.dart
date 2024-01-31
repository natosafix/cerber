import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/presentation/questions/questions_bloc/questions_bloc_base.dart';

class RadioInput extends StatefulWidget {
  const RadioInput(
    this.question,
    this.answer,
    this.allowEdit, {
    super.key,
  });

  final Question question;
  final Answer answer;
  final bool allowEdit;

  @override
  State<RadioInput> createState() => _RadioInputState();
}

class _RadioInputState extends State<RadioInput> {
  late String? _selected;

  @override
  void initState() {
    if (widget.allowEdit) {
      _selected = null;
    } else {
      _selected = widget.answer.answers.first;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.question.question,
          style: TextStyle(color: Theme.of(context).hintColor),
        ),
        for (final option in widget.question.options)
          RadioListTile(
            title: Text(option),
            value: option,
            groupValue: _selected,
            onChanged: widget.allowEdit ? (_) => _onChanged(context, option) : (_) {},
            contentPadding: EdgeInsets.zero,
          ),
      ],
    );
  }

  void _onChanged(BuildContext context, String value) {
    setState(() {
      _selected = value;
    });
    context.read<QuestionsBlocBase>().add(RadioChanged(question: widget.question, selectedValue: value));
  }
}
