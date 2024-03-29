import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_bloc/authentication_form_bloc.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_bloc/authentication_form_status.dart';
import 'package:project/presentation/authentication/authentication_form/authentication_form_screen/finish_button_widget.dart';
import 'package:project/utils/extensions/context_x.dart';

class AuthenticationFormScreenBase extends StatelessWidget {
  const AuthenticationFormScreenBase({
    required this.authenticationFormBloc,
    required this.inputFields,
    required this.title,
    required this.finishButtonText,
    required this.onSuccess,
    super.key,
  });

  final AuthenticationFormBloc authenticationFormBloc;
  final List<Widget> inputFields;
  final String title;
  final String finishButtonText;
  final Function(BuildContext context) onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authenticationFormBloc,
      child: BlocListener<AuthenticationFormBloc, AuthenticationFormState>(
        listener: (context, state) => _statusChanged(context, state.authenticationStatus),
        listenWhen: (previous, current) => current.authenticationStatus is! UnknownStatus,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: context.appBarForegroundColor(),
            elevation: 0,
            title: Text(title),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ..._createInputs(),
                const SizedBox(height: 20),
                FinishButtonWigdet(text: finishButtonText),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _createInputs() {
    final result = <Widget>[];

    for (final input in inputFields) {
      result.add(input);
      result.add(const SizedBox(height: 10));
    }

    return result..removeLast();
  }

  void _statusChanged(BuildContext context, AuthenticationFormStatus status) {
    switch (status) {
      case Processing():
        // dismissing keyboard
        FocusManager.instance.primaryFocus?.unfocus();
      case Success():
        onSuccess(context);
      case Failure():
        context.showSnackbar(status.errorMessage);
      case UnknownStatus():
        break;
    }
  }
}
