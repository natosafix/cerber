import 'package:formz/formz.dart';
import 'package:project/l10n/generated/l10n.dart';

enum NameValidationError {
  empty;

  String get errorMessage {
    return switch (this) {
      NameValidationError.empty => L10n.current.shouldntBeEmpty,
    };
  }
}

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    return value.isEmpty ? NameValidationError.empty : null;
  }
}
