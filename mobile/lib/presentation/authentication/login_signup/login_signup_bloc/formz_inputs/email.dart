import 'package:formz/formz.dart';

enum EmailValidationError {
  empty,
  invalid;

  String get errorMessage {
    return switch (this) {
      EmailValidationError.empty => "Не должно быть пустым",
      EmailValidationError.invalid => "Некорректный адрес",
    };
  }
}

class Email extends FormzInput<String, EmailValidationError> with FormzInputErrorCacheMixin {
  Email.pure() : super.pure('');
  Email.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) return EmailValidationError.empty;
    return _emailRegex.hasMatch(value) ? null : EmailValidationError.invalid;
  }

  static final _emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'
  );
}
