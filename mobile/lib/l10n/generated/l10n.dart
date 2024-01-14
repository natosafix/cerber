// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class L10n {
  L10n();

  static L10n? _current;

  static L10n get current {
    assert(_current != null,
        'No instance of L10n was loaded. Try to initialize the L10n delegate before accessing L10n.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<L10n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = L10n();
      L10n._current = instance;

      return instance;
    });
  }

  static L10n of(BuildContext context) {
    final instance = L10n.maybeOf(context);
    assert(instance != null,
        'No instance of L10n present in the widget tree. Did you add L10n.delegate in localizationsDelegates?');
    return instance!;
  }

  static L10n? maybeOf(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  /// `Events`
  String get events {
    return Intl.message(
      'Events',
      name: 'events',
      desc: '',
      args: [],
    );
  }

  /// `You don''t have any events`
  String get youHaveNoEvents {
    return Intl.message(
      'You don\'\'t have any events',
      name: 'youHaveNoEvents',
      desc: '',
      args: [],
    );
  }

  /// `Where`
  String get where {
    return Intl.message(
      'Where',
      name: 'where',
      desc: '',
      args: [],
    );
  }

  /// `When`
  String get when {
    return Intl.message(
      'When',
      name: 'when',
      desc: '',
      args: [],
    );
  }

  /// `more`
  String get more {
    return Intl.message(
      'more',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `less`
  String get less {
    return Intl.message(
      'less',
      name: 'less',
      desc: '',
      args: [],
    );
  }

  /// `Download database`
  String get downloadDatabase {
    return Intl.message(
      'Download database',
      name: 'downloadDatabase',
      desc: '',
      args: [],
    );
  }

  /// `Begin checking`
  String get beginChecking {
    return Intl.message(
      'Begin checking',
      name: 'beginChecking',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get logIn {
    return Intl.message(
      'Log In',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Log Into Account`
  String get logIntoAccount {
    return Intl.message(
      'Log Into Account',
      name: 'logIntoAccount',
      desc: '',
      args: [],
    );
  }

  /// `Shouldn''t be empty`
  String get shouldntBeEmpty {
    return Intl.message(
      'Shouldn\'\'t be empty',
      name: 'shouldntBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address`
  String get invalidEmailAddress {
    return Intl.message(
      'Invalid email address',
      name: 'invalidEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Visitors`
  String get visitors {
    return Intl.message(
      'Visitors',
      name: 'visitors',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Scan visitor''s QR code`
  String get scanVisitorsQrCode {
    return Intl.message(
      'Scan visitor\'\'s QR code',
      name: 'scanVisitorsQrCode',
      desc: '',
      args: [],
    );
  }

  /// `Must have at least {minLength} characters`
  String passwordMustHaveAtLeastNChars(num minLength) {
    return Intl.message(
      'Must have at least $minLength characters',
      name: 'passwordMustHaveAtLeastNChars',
      desc: '',
      args: [minLength],
    );
  }

  /// `Must have at least 1 capital letter`
  String get passwordMustHaveAtLeast1CapitalLetter {
    return Intl.message(
      'Must have at least 1 capital letter',
      name: 'passwordMustHaveAtLeast1CapitalLetter',
      desc: '',
      args: [],
    );
  }

  /// `Must consist of letters, numbers and special characters`
  String get passwordMustConsistOfLettersAndNumbers {
    return Intl.message(
      'Must consist of letters, numbers and special characters',
      name: 'passwordMustConsistOfLettersAndNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Must have at least 1 digit`
  String get passwordMustHaveAtLeast1Digit {
    return Intl.message(
      'Must have at least 1 digit',
      name: 'passwordMustHaveAtLeast1Digit',
      desc: '',
      args: [],
    );
  }

  /// `Must have at least 1 of the following characters: {specialChars}`
  String passwordMustHaveAtLeast1SpecialChar(String specialChars) {
    return Intl.message(
      'Must have at least 1 of the following characters: $specialChars',
      name: 'passwordMustHaveAtLeast1SpecialChar',
      desc: '',
      args: [specialChars],
    );
  }

  /// `Not Downloaded`
  String get notDownloaded {
    return Intl.message(
      'Not Downloaded',
      name: 'notDownloaded',
      desc: 'Database not downloaded',
      args: [],
    );
  }

  /// `Last downloaded`
  String get lastDownloaded {
    return Intl.message(
      'Last downloaded',
      name: 'lastDownloaded',
      desc: 'Database last downloaded',
      args: [],
    );
  }

  /// `Something went wrong...`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong...',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `You have signed up successfully`
  String get youHaveSignUpsuccessfully {
    return Intl.message(
      'You have signed up successfully',
      name: 'youHaveSignUpsuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `{date} at {time}`
  String formattedDateTime(DateTime date, DateTime time) {
    final DateFormat dateDateFormat = DateFormat.yMd(Intl.getCurrentLocale());
    final String dateString = dateDateFormat.format(date);

    final DateFormat timeDateFormat = DateFormat.Hm(Intl.getCurrentLocale());
    final String timeString = timeDateFormat.format(time);

    return Intl.message(
      '$dateString at $timeString',
      name: 'formattedDateTime',
      desc: '',
      args: [dateString, timeString],
    );
  }

  /// `Your QR code`
  String get yourQrCode {
    return Intl.message(
      'Your QR code',
      name: 'yourQrCode',
      desc: '',
      args: [],
    );
  }

  /// `Visitor''s questionnaire`
  String get visitorsQuestions {
    return Intl.message(
      'Visitor\'\'s questionnaire',
      name: 'visitorsQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Questionnaire is empty`
  String get questionsEmpty {
    return Intl.message(
      'Questionnaire is empty',
      name: 'questionsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Failed to read QR code`
  String get failedToReadQrCode {
    return Intl.message(
      'Failed to read QR code',
      name: 'failedToReadQrCode',
      desc: '',
      args: [],
    );
  }

  /// `Bad QR code format`
  String get badQrCodeFormat {
    return Intl.message(
      'Bad QR code format',
      name: 'badQrCodeFormat',
      desc: '',
      args: [],
    );
  }

  /// `Could not find this visitor`
  String get failedToFindSuchVisitor {
    return Intl.message(
      'Could not find this visitor',
      name: 'failedToFindSuchVisitor',
      desc: '',
      args: [],
    );
  }

  /// `QR code is correct however this visitor is not in the database, they probably bought the ticket on spot`
  String get boughtTicketOnSpot {
    return Intl.message(
      'QR code is correct however this visitor is not in the database, they probably bought the ticket on spot',
      name: 'boughtTicketOnSpot',
      desc: '',
      args: [],
    );
  }

  /// `Invalid password or email`
  String get invalidPasswordOrEmail {
    return Intl.message(
      'Invalid password or email',
      name: 'invalidPasswordOrEmail',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<L10n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<L10n> load(Locale locale) => L10n.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
