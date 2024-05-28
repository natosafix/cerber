import 'package:flutter/material.dart';

class CheckboxInput extends StatefulWidget {
  const CheckboxInput({
    super.key,
    required this.label,
    required this.options,
    this.onChanged,
  });

  final String label;
  final List<(String, bool)> options;
  final void Function(String, bool)? onChanged;

  @override
  State<CheckboxInput> createState() => _CheckboxInputState();
}

class _CheckboxInputState extends State<CheckboxInput> {
  late final Map<String, bool> _selectionMap;

  @override
  void initState() {
    _selectionMap = {
      for (final (option, isSelected) in widget.options) option: isSelected,
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(color: Theme.of(context).hintColor),
        ),
        for (final entry in _selectionMap.entries)
          CheckboxListTile(
            title: Text(entry.key),
            value: entry.value,
            onChanged: (value) => _onChanged(entry.key, value!),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
      ],
    );
  }

  void _onChanged(String option, bool value) {
    if (widget.onChanged == null) return;

    widget.onChanged!(option, value);

    setState(() {
      _selectionMap[option] = value;
    });
  }
}
