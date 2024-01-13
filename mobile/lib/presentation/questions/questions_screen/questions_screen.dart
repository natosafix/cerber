import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/question_type.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/presentation/questions/qr_code_screen.dart';
import 'package:project/presentation/questions/questions_bloc/questions_bloc.dart';
import 'package:project/presentation/questions/questions_screen/inputs/checkbox_input.dart';
import 'package:project/presentation/questions/questions_screen/inputs/radio_input.dart';
import 'package:project/presentation/questions/questions_screen/inputs/text_input.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({
    required this.visitor,
    required this.event,
    super.key,
  });

  static Route route(Visitor? visitor, Event event) {
    return MaterialPageRoute(builder: (context) => QuestionsScreen(visitor: visitor, event: event));
  }

  final Visitor? visitor;
  final Event event;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionsBloc(visitor: visitor, event: event),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("QUESTIONS"), //TODO
        ),
        body: BlocConsumer<QuestionsBloc, QuestionsState>(
          listener: _onListen,
          builder: (context, state) {
            if (state.questionsMap == null) {
              return const Center(
                child: Text("No questions"), //TODO
              );
            }

            final widgets = <Widget>[];

            for (final entry in state.questionsMap!.entries) {
              final question = entry.key;
              final answer = entry.value;
              widgets.add(switch (question.questionType) {
                QuestionType.text => TextInput(question, answer),
                QuestionType.radio => RadioInput(question, answer),
                QuestionType.checkbox => CheckboxInput(question, answer),
              });
              widgets.add(const SizedBox(height: 8));
            }

            widgets.add(SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => context.read<QuestionsBloc>().add(SaveNewVisitor()),
                child: const Text("SAve"), //TODO
              ),
            ));

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Column(
                  children: widgets,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onListen(BuildContext context, QuestionsState state) {
    if (state.qrCodeData == null) return;

    showModalBottomSheet(
      context: context,
      builder: (context) => QrCodeScreen(qrCodeData: state.qrCodeData!),
    );
  }
}
