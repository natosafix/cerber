import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_bloc/authentication_form_bloc.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  var hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationFormBloc, AuthenticationFormState>(
      builder: (context, state) {
        return TextField(
          obscureText: hidePassword,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            hintText: L10n.current.password,
            errorText: state.password.displayError?.errorMessage,
            suffixIcon: IconButton(
              icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              color: Colors.grey,
              onPressed: () => setState(() => hidePassword = !hidePassword),
            ),
          ),
          enabled: !state.isProcessing,
          onChanged: (value) => context.read<AuthenticationFormBloc>().add(PasswordChanged(value)),
        );
      },
    );
  }
}
