import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_bloc/authentication_form_bloc.dart';

class FinishButtonWigdet extends StatelessWidget {
  const FinishButtonWigdet({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationFormBloc, AuthenticationFormState>(
      buildWhen: (previous, current) => isEnabled(previous) != isEnabled(current),
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed:
                isEnabled(state) ? () => context.read<AuthenticationFormBloc>().add(const FinishPressed()) : null,
            child: !state.isProcessing
                ? Text(text)
                : const SizedBox.square(
                    dimension: 15,
                    child: CircularProgressIndicator(color: Colors.grey),
                  ),
          ),
        );
      },
    );
  }

  bool isEnabled(AuthenticationFormState state) {
    if (state.isProcessing) return false;
    return state.isValid;
  }
}
