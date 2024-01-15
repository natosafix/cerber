import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/presentation/questions/questions_bloc/questions_bloc.dart';
import 'package:project/presentation/questions/questions_screen/questions_screen.dart';

class CheckboxInput extends StatefulWidget {
  const CheckboxInput(
    this.question,
    this.answer,
    this.filling, {
    super.key,
  });

  final Question question;
  final Answer answer;
  final bool filling;

  @override
  State<CheckboxInput> createState() => _CheckboxInputState();
}

class _CheckboxInputState extends State<CheckboxInput> {
  late final Map<String, bool> _selected;

  @override
  void initState() {
    _selected = {
      for (final option in widget.question.options) option: widget.answer.answers.contains(option),
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
              onChanged: widget.filling ? (value) => _onChanged(context, option, value) : (_) {},
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            );
          }),
        ],
      ),
    );
  }

  void _onChanged(BuildContext context, String option, bool? value) {
    setState(() {
      _selected[option] = value!;
    });
    context.read<QuestionsBloc>().add(CheckboxChanged(
          question: widget.question,
          value: option,
          selected: value!,
        ));
  }
}
