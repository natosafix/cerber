import 'package:formz/formz.dart';
import 'package:project/l10n/generated/l10n.dart';

enum PasswordValidationError {
  empty,
  tooShort,
  noCapitalLetter,
  disallowedChars,
  noDigit,
  noSpecialCharacter;

  String get errorMessage {
    return switch (this) {
      PasswordValidationError.empty => L10n.current.shouldntBeEmpty,
      PasswordValidationError.tooShort => L10n.current.passwordMustHaveAtLeastNChars(Password.minPasswordLength),
      PasswordValidationError.noCapitalLetter => L10n.current.passwordMustHaveAtLeast1CapitalLetter,
      PasswordValidationError.disallowedChars => L10n.current.passwordMustConsistOfLettersAndNumbers,
      PasswordValidationError.noDigit => L10n.current.passwordMustHaveAtLeast1Digit,
      PasswordValidationError.noSpecialCharacter =>
        L10n.current.passwordMustHaveAtLeast1SpecialChar(Password.specialChars.join(''))
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
    ...specialChars.map((e) => e.codeUnitAt(0)),        //  special chars
  ];

  static final List<String> specialChars = r'!@#$%^&*()?_-'.split('');

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;

    var hasCapital = false;
    var hasDigit = false;
    var hasSpecialChar = false;
    var length = 0;

    for (final c in value.runes) {
      if (!_allowedChars.contains(c)) return PasswordValidationError.disallowedChars;
      length++;

      final char = String.fromCharCode(c);

      if (int.tryParse(char) != null) {
        hasDigit = true;
        continue;
      }

      if (specialChars.contains(char)) {
        hasSpecialChar = true;
        continue;
      }

      if (char == char.toUpperCase()) {
        hasCapital = true;
        continue;
      }
    }

    if (!hasCapital) return PasswordValidationError.noCapitalLetter;
    if (!hasDigit) return PasswordValidationError.noDigit;
    if (!hasSpecialChar) return PasswordValidationError.noSpecialCharacter;

    if (length < minPasswordLength) return PasswordValidationError.tooShort;

    return null;
  }
}
