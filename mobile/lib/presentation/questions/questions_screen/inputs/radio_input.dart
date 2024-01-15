import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/presentation/questions/questions_bloc/questions_bloc.dart';
import 'package:project/presentation/questions/questions_screen/questions_screen.dart';

class RadioInput extends StatefulWidget {
  const RadioInput(
    this.question,
    this.answer,
    this.filling, {
    super.key,
  });

  final Question question;
  final Answer answer;
  final bool filling;

  @override
  State<RadioInput> createState() => _RadioInputState();
}

class _RadioInputState extends State<RadioInput> {
  late String? _selected;

  @override
  void initState() {
    if (widget.filling) {
      _selected = null;
    } else {
      _selected = widget.answer.answers.first;
    }
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
              onChanged: widget.filling ? (_) => _onChanged(context, option) : (_) {},
              contentPadding: EdgeInsets.zero,
            );
          }),
        ],
      ),
    );
  }

  void _onChanged(BuildContext context, String value) {
    setState(() {
      _selected = value;
    });
    context.read<QuestionsBloc>().add(RadioChanged(question: widget.question, selectedValue: value));
  }
}
