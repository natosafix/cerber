import 'package:flutter/material.dart';

class RadioInput extends StatefulWidget {
  const RadioInput({
    super.key,
    required this.label,
    required this.options,
    required this.selectedOption,
    this.onChanged,
  });

  final String label;
  final List<String> options;
  final String? selectedOption;
  final ValueChanged<String>? onChanged;

  @override
  State<RadioInput> createState() => _RadioInputState();
}

class _RadioInputState extends State<RadioInput> {
  late String? _groupValue;

  @override
  void initState() {
    _groupValue = widget.selectedOption;
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
        for (final option in widget.options)
          RadioListTile(
            title: Text(option),
            value: option,
            groupValue: _groupValue,
            onChanged: _onChanged,
            contentPadding: EdgeInsets.zero,
          ),
      ],
    );
  }

  void _onChanged(String? value) {
    if (widget.onChanged == null) return;
    
    widget.onChanged!(value!);

    setState(() {
      _groupValue = value;
    });
  }
}
