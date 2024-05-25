import 'package:flutter/material.dart';
import 'package:project/l10n/generated/l10n.dart';

class NameInput extends StatelessWidget {
  const NameInput({
    super.key,
    required this.isEnabled,
    required this.errorText,
    required this.onChanged,
  });

  final bool isEnabled;
  final String? errorText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          hintText: L10n.current.name,
          errorText: errorText,
          errorMaxLines: 2,
        ),
        enabled: isEnabled,
        onChanged: onChanged,
      ),
    );
  }
}
