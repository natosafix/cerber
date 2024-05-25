import 'package:flutter/material.dart';
import 'package:project/presentation/widgets/circular_progress_indicator_inbutton.dart';
import 'package:project/presentation/widgets/full_width_button.dart';

class FinishButtonWigdet extends StatelessWidget {
  const FinishButtonWigdet({
    super.key,
    required this.text,
    required this.isEnabled,
    required this.showLoadingIndicator,
    required this.onPressed,
  });

  final String text;
  final bool isEnabled;
  final bool showLoadingIndicator;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FullWidthButton(
      onPressed: isEnabled ? onPressed : null,
      child: showLoadingIndicator ? const CircularProgressIndicatorInbutton() : Text(text),
    );
  }
}
