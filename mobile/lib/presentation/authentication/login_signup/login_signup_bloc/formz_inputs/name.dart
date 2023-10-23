import 'package:formz/formz.dart';

enum NameValidationError {
  empty;

  String get errorMessage {
    return switch (this) {
      NameValidationError.empty => "Не должно быть пустым",
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
