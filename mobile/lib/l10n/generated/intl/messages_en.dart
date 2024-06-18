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

  static String m3(count) => "Unsynced visitors: ${count}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "addNewVisitor":
            MessageLookupByLibrary.simpleMessage("Add new visitor"),
        "badQrCodeFormat":
            MessageLookupByLibrary.simpleMessage("Bad QR code format"),
        "beginChecking": MessageLookupByLibrary.simpleMessage("Begin checking"),
        "boughtTicketOnSpot": MessageLookupByLibrary.simpleMessage(
            "QR code is correct however this visitor is not in the database, they probably bought the ticket on spot"),
        "chooseTicket": MessageLookupByLibrary.simpleMessage("Choose a ticket"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Create Account"),
        "downloadDatabase":
            MessageLookupByLibrary.simpleMessage("Download database"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "events": MessageLookupByLibrary.simpleMessage("Events"),
        "failedToFindSuchVisitor":
            MessageLookupByLibrary.simpleMessage("Could not find this visitor"),
        "failedToReadQrCode":
            MessageLookupByLibrary.simpleMessage("Failed to read QR code"),
        "fillTheForm": MessageLookupByLibrary.simpleMessage("Fill the form"),
        "form": MessageLookupByLibrary.simpleMessage("Form"),
        "formattedDateTime": m0,
        "invalidEmailAddress":
            MessageLookupByLibrary.simpleMessage("Invalid email address"),
        "invalidPasswordOrEmail":
            MessageLookupByLibrary.simpleMessage("Invalid password or email"),
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
        "pleaseFillTheEntireForm":
            MessageLookupByLibrary.simpleMessage("Please fill the entire form"),
        "qrCodeAlreadyBeenScanned": MessageLookupByLibrary.simpleMessage(
            "This QR code has already been scanned"),
        "questionsEmpty":
            MessageLookupByLibrary.simpleMessage("Questionnaire is empty"),
        "retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "scanVisitorsQrCode":
            MessageLookupByLibrary.simpleMessage("Scan visitor\'\'s QR code"),
        "shouldntBeEmpty":
            MessageLookupByLibrary.simpleMessage("Shouldn\'\'t be empty"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "somethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Something went wrong..."),
        "sync": MessageLookupByLibrary.simpleMessage("Sync"),
        "ticket": MessageLookupByLibrary.simpleMessage("Ticket"),
        "unsyncedVisitors": m3,
        "visitors": MessageLookupByLibrary.simpleMessage("Visitors"),
        "visitorsInformation":
            MessageLookupByLibrary.simpleMessage("Visitor Information"),
        "when": MessageLookupByLibrary.simpleMessage("When"),
        "where": MessageLookupByLibrary.simpleMessage("Where"),
        "youHaveNoEvents": MessageLookupByLibrary.simpleMessage(
            "You don\'\'t have any events"),
        "youHaveSignUpsuccessfully": MessageLookupByLibrary.simpleMessage(
            "You have signed up successfully"),
        "yourQrCode": MessageLookupByLibrary.simpleMessage("Your QR code")
      };
}
