import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_bloc/authentication_form_bloc.dart';

class NameInput extends StatelessWidget {
  const NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationFormBloc, AuthenticationFormState>(
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            hintText: L10n.current.name,
            errorText: state.name!.displayError?.errorMessage,
          ),
          enabled: !state.isProcessing,
          onChanged: (value) => context.read<AuthenticationFormBloc>().add(NameChanged(value)),
        );
      },
    );
  }
}
