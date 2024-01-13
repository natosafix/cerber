// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(date, time) => "${date} at ${time}";

  static String m1(specialChars) =>
      "Must have at least 1 of the following characters: ${specialChars}";

  static String m2(minLength) => "Must have at least ${minLength} characters";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "beginChecking": MessageLookupByLibrary.simpleMessage("Begin checking"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Create Account"),
        "downloadDatabase":
            MessageLookupByLibrary.simpleMessage("Download database"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "events": MessageLookupByLibrary.simpleMessage("Events"),
        "formattedDateTime": m0,
        "invalidEmailAddress":
            MessageLookupByLibrary.simpleMessage("Invalid email address"),
        "lastDownloaded":
            MessageLookupByLibrary.simpleMessage("Last downloaded"),
        "less": MessageLookupByLibrary.simpleMessage("less"),
        "logIn": MessageLookupByLibrary.simpleMessage("Log In"),
        "logIntoAccount":
            MessageLookupByLibrary.simpleMessage("Log Into Account"),
        "more": MessageLookupByLibrary.simpleMessage("more"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "notDownloaded": MessageLookupByLibrary.simpleMessage("Not Downloaded"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordMustConsistOfLettersAndNumbers":
            MessageLookupByLibrary.simpleMessage(
                "Must consist of letters, numbers and special characters"),
        "passwordMustHaveAtLeast1CapitalLetter":
            MessageLookupByLibrary.simpleMessage(
                "Must have at least 1 capital letter"),
        "passwordMustHaveAtLeast1Digit":
            MessageLookupByLibrary.simpleMessage("Must have at least 1 digit"),
        "passwordMustHaveAtLeast1SpecialChar": m1,
        "passwordMustHaveAtLeastNChars": m2,
        "questionsEmpty":
            MessageLookupByLibrary.simpleMessage("Questionnaire is empty"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "scanVisitorsQrCode":
            MessageLookupByLibrary.simpleMessage("Scan visitor\'\'s QR code"),
        "shouldntBeEmpty":
            MessageLookupByLibrary.simpleMessage("Shouldn\'\'t be empty"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "somethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Something went wrong..."),
        "visitors": MessageLookupByLibrary.simpleMessage("Visitors"),
        "visitorsQuestions":
            MessageLookupByLibrary.simpleMessage("Visitor\'\'s questionnaire"),
        "when": MessageLookupByLibrary.simpleMessage("When"),
        "where": MessageLookupByLibrary.simpleMessage("Where"),
        "youHaveNoEvents": MessageLookupByLibrary.simpleMessage(
            "You don\'\'t have any events"),
        "youHaveSignUpsuccessfully": MessageLookupByLibrary.simpleMessage(
            "You have signed up successfully"),
        "yourQrCode": MessageLookupByLibrary.simpleMessage("Your QR code")
      };
}
