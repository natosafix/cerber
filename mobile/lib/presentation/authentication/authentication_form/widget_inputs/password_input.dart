import 'package:flutter/material.dart';
import 'package:project/l10n/generated/l10n.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    super.key,
    required this.isEnabled,
    required this.errorText,
    required this.onChanged,
  });

  final bool isEnabled;
  final String? errorText;
  final ValueChanged<String> onChanged;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  var hidePassword = true;

  void _toggleHidePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        obscureText: hidePassword,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          hintText: L10n.current.password,
          errorText: widget.errorText,
          errorMaxLines: 2,
          suffixIcon: IconButton(
            icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            color: Colors.grey,
            onPressed: _toggleHidePassword,
          ),
        ),
        enabled: widget.isEnabled,
        onChanged: widget.onChanged,
      ),
    );
  }
}
