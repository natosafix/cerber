import 'package:flutter/material.dart';

class CircularProgressIndicatorInbutton extends StatelessWidget {
  const CircularProgressIndicatorInbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: 15,
      child: CircularProgressIndicator(color: Colors.grey),
    );
  }
}
