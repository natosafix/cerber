import 'package:formz/formz.dart';

enum PasswordValidationError {
  empty,
  tooShort,
  noCapitalLetter,
  disallowedChars,
  noDigit;

  String get errorMessage {
    return switch (this) {
      PasswordValidationError.empty => "Не должно быть пустым",
      PasswordValidationError.tooShort => "Должен иметь минимум ${Password.minPasswordLength} символов",
      PasswordValidationError.noCapitalLetter => "Должен иметь минимум 1 заглавную букву",
      PasswordValidationError.disallowedChars => "Должен состоять из латинских букв и цифр",
      PasswordValidationError.noDigit => "Должен иметь минимум 1 цифру",
    };
  }
}

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  static const minPasswordLength = 8;
  
  static final List<int> _allowedChars = [
    ...List.generate(26, (i) => i + 'a'.codeUnitAt(0)), // 'a' to 'z'
    ...List.generate(26, (i) => i + 'A'.codeUnitAt(0)), // 'A' to 'Z'
    ...List.generate(10, (i) => i + '0'.codeUnitAt(0)), // '0' to '9'
  ];

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;

    var hasCapital = false;
    var hasDigit = false;
    var length = 0;

    for (final c in value.runes) {
      if (!_allowedChars.contains(c)) return PasswordValidationError.disallowedChars;

      final char = String.fromCharCode(c);

      final isInt = int.tryParse(char) != null;

      if (isInt) hasDigit = true;

      if (!isInt && char == char.toUpperCase()) hasCapital = true;

      length++;
    }

    if (!hasCapital) return PasswordValidationError.noCapitalLetter;
    if (!hasDigit) return PasswordValidationError.noDigit;

    if (length < minPasswordLength) return PasswordValidationError.tooShort;

    return null;
  }
}
