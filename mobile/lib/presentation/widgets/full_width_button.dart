import 'package:flutter/material.dart';

class FullWidthButton extends StatelessWidget {
  const FullWidthButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.isEnabled = true,
  }) : showLoadingIndicator = false;

  const FullWidthButton.withLoading({
    super.key,
    required this.child,
    required this.isEnabled,
    required this.showLoadingIndicator,
    required this.onPressed,
  });

  final Widget child;
  final VoidCallback onPressed;
  final bool isEnabled;
  final bool showLoadingIndicator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: isEnabled ? onPressed : null,
        child: showLoadingIndicator
            ? const SizedBox.square(
                dimension: 15,
                child: CircularProgressIndicator(color: Colors.grey),
              )
            : child,
      ),
    );
  }
}
