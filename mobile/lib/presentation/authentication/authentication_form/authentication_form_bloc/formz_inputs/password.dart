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
    final l10n = L10n.current;
    return switch (this) {
      PasswordValidationError.empty => l10n.shouldntBeEmpty,
      PasswordValidationError.tooShort => l10n.passwordMustHaveAtLeastNChars(Password.minPasswordLength),
      PasswordValidationError.noCapitalLetter => l10n.passwordMustHaveAtLeast1CapitalLetter,
      PasswordValidationError.disallowedChars => l10n.passwordMustConsistOfLettersAndNumbers,
      PasswordValidationError.noDigit => l10n.passwordMustHaveAtLeast1Digit,
      PasswordValidationError.noSpecialCharacter => l10n.passwordMustHaveAtLeast1SpecialChar(Password.specialChars)
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
    ...specialChars.split('').map((e) => e.codeUnitAt(0)), // special chars
  ];

  static const String specialChars = r'!@#$%^&*()?_-';

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
