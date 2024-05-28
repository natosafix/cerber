import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
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
        labelText: label,
      ),
      onChanged: onChanged,
    );
  }
}
