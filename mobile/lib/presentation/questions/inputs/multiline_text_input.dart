import 'package:flutter/material.dart';

class MultilineTextInput extends StatelessWidget {
  const MultilineTextInput({
    super.key,
    required this.label,
    required this.initialValue,
    this.onChanged,
  });

  final String label;
  final String initialValue;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      readOnly: onChanged == null,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      onChanged: onChanged,
    );
  }
}
