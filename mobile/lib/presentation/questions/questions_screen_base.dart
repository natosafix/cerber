import 'package:flutter/material.dart';
import 'package:project/presentation/widgets/flat_app_bar.dart';

class QuestionsScreenBase extends StatelessWidget {
  const QuestionsScreenBase({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FlatAppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: child,
      ),
    );
  }
}
