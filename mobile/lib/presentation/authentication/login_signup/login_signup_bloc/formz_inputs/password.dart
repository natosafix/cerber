import 'package:formz/formz.dart';

enum PasswordValidationError {
  empty,
  tooShort,
  noCapitalLetter,
  noDigit;

  String get errorMessage {
    return switch (this) {
      PasswordValidationError.empty => "Не должно быть пустым",
      PasswordValidationError.tooShort => "Должен иметь минимум ${Password.minPasswordLength} символов",
      PasswordValidationError.noCapitalLetter => "Должен иметь минимум 1 заглавную букву",
      PasswordValidationError.noDigit => "Должен иметь минимум 1 цифру",
    };
  }
}

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  static const minPasswordLength = 8;

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;

    final trimmed = value.trim();

    if (trimmed.length < minPasswordLength) return PasswordValidationError.tooShort;

    var hasCapital = false;
    var hasDigit = false;

    for (final c in trimmed.runes) {
      final char = String.fromCharCode(c);
      final isInt = int.tryParse(char) != null;

      if (isInt) hasDigit = true;

      if (!isInt && char == char.toUpperCase()) hasCapital = true;
    }

    if (!hasCapital) return PasswordValidationError.noCapitalLetter;
    if (!hasDigit) return PasswordValidationError.noDigit;

    return null;
  }
}
