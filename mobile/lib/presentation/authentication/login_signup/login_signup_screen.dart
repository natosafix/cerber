import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/l10n/generated/l10n.dart';

import '../../../domain/repositories/authentication_repository/authentication_repository.dart';
import '../../../utils/theme_util.dart';
import '../authentication_bloc/authentication_bloc.dart';
import 'login_signup_bloc/login_signup_bloc.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({required this.withName, super.key});

  final bool withName;

  static Route route({required bool withName}) {
    return MaterialPageRoute(
      builder: (context) => LoginSignupScreen(withName: withName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginSignupBloc(
        withName: withName,
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: _LoginSignupView(withName: withName),
    );
  }
}

class _LoginSignupView extends StatefulWidget {
  const _LoginSignupView({required this.withName});

  final bool withName;

  @override
  State<_LoginSignupView> createState() => _LoginSignupViewState();
}

class _LoginSignupViewState extends State<_LoginSignupView> {
  var hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ThemeUtil.isLight(context) ? Colors.black : Colors.white,
        elevation: 0,
        title: Text(widget.withName ? L10n.current.createAccount : L10n.current.logIntoAccount),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _emailField(),
            const SizedBox(height: 10),
            if (widget.withName)
              _nameField(),
            if (widget.withName)
              const SizedBox(height: 10),
            _passwordField(),
            const SizedBox(height: 20),
            _finishButton(),
          ],
        ),
      ),
    );
  }

  Widget _emailField() {
    return BlocBuilder<LoginSignupBloc, LoginSignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            hintText: L10n.current.email,
            errorText: state.email.displayError?.errorMessage,
          ),
          onChanged: (value) => context.read<LoginSignupBloc>().add(EmailChanged(value)),
        );
      },
    );
  }

  Widget _nameField() {
    return BlocBuilder<LoginSignupBloc, LoginSignupState>(
      buildWhen: (previous, current) => current.name != null && previous.name != current.name,
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            hintText: L10n.current.name,
            errorText: state.name!.displayError?.errorMessage,
          ),
          onChanged: (value) => context.read<LoginSignupBloc>().add(NameChanged(value)),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginSignupBloc, LoginSignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
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
          onChanged: (value) => context.read<LoginSignupBloc>().add(PasswordChanged(value)),
        );
      },
    );
  }

  Widget _finishButton() {
    return BlocBuilder<LoginSignupBloc, LoginSignupState>(
      buildWhen: (previous, current) => previous.isValid != current.isValid,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: state.isValid ? () => _finishPressed(context) : null,
            child: Text(state.name == null ? L10n.current.logIn : L10n.current.signUp),
          ),
        );
      },
    );
  }

  void _finishPressed(BuildContext context) async {
    final result = await context.read<LoginSignupBloc>().finish();

    if (result.isSuccess) {
      if (!context.mounted) return;
      context.read<AuthenticationBloc>().add(Authenticate(token: result.success));
      return;
    }

    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(result.failure.message ?? "Unknown Error")));
  }
}
