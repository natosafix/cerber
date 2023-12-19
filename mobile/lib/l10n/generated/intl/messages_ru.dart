// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(specialChars) =>
      "Должен иметь минимум 1 из специальных символов: ${specialChars}";

  static String m1(minLength) => "Должен иметь минимум ${minLength} символов";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("Добавить"),
        "beginChecking":
            MessageLookupByLibrary.simpleMessage("Начать проверку"),
        "createAccount":
            MessageLookupByLibrary.simpleMessage("Создать аккаунт"),
        "downloadDatabase":
            MessageLookupByLibrary.simpleMessage("Скачать базу"),
        "email": MessageLookupByLibrary.simpleMessage("Почта"),
        "events": MessageLookupByLibrary.simpleMessage("Мероприятия"),
        "invalidEmailAddress":
            MessageLookupByLibrary.simpleMessage("Некорректный адрес"),
        "lastDownloaded": MessageLookupByLibrary.simpleMessage("Скачана"),
        "less": MessageLookupByLibrary.simpleMessage("меньше"),
        "logIn": MessageLookupByLibrary.simpleMessage("Войти"),
        "logIntoAccount":
            MessageLookupByLibrary.simpleMessage("Войти в аккаунт"),
        "more": MessageLookupByLibrary.simpleMessage("больше"),
        "name": MessageLookupByLibrary.simpleMessage("Имя"),
        "notDownloaded": MessageLookupByLibrary.simpleMessage("Не скачана"),
        "password": MessageLookupByLibrary.simpleMessage("Пароль"),
        "passwordMustConsistOfLettersAndNumbers":
            MessageLookupByLibrary.simpleMessage(
                "Должен состоять из латинских букв и цифр, и специальных символов"),
        "passwordMustHaveAtLeast1CapitalLetter":
            MessageLookupByLibrary.simpleMessage(
                "Должен иметь минимум 1 заглавную букву"),
        "passwordMustHaveAtLeast1Digit": MessageLookupByLibrary.simpleMessage(
            "Должен иметь минимум 1 цифру"),
        "passwordMustHaveAtLeast1SpecialChar": m0,
        "passwordMustHaveAtLeastNChars": m1,
        "scanVisitorsQrCode": MessageLookupByLibrary.simpleMessage(
            "Сканировать QR-код посетителя"),
        "shouldntBeEmpty":
            MessageLookupByLibrary.simpleMessage("Не должно быть пустым"),
        "signUp": MessageLookupByLibrary.simpleMessage("Зарегаться"),
        "somethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Что-то пошло не так..."),
        "visitors": MessageLookupByLibrary.simpleMessage("Посетители"),
        "when": MessageLookupByLibrary.simpleMessage("Когда"),
        "where": MessageLookupByLibrary.simpleMessage("Где"),
        "youHaveNoEvents":
            MessageLookupByLibrary.simpleMessage("У вас нет мероприятий")
      };
}
