import 'package:flutter/material.dart';
import 'package:project/presentation/widgets/flat_app_bar.dart';

class AuthenticationScreenBase extends StatelessWidget {
  const AuthenticationScreenBase({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: FlatAppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}
