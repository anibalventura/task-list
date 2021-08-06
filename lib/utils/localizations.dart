import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
? Handling strings localizations and translations.
*/

class AppLocalizations {
  AppLocalizations(
    this._locale,
  );

  final Locale _locale;
  late Map<String, String> _localizedStrings;

  /* 
  Helper method to keep the code in the widgets concise.
  Localizations are accessed using an InheritedWidget "of" syntax.
  */
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Allowing simple access to the delegate from the MaterialApp.
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Load the language JSON file from the "lang" folder.
  Future<bool> load() async {
    final jsonString = await rootBundle.loadString(
      'assets/lang/${_locale.languageCode}.json',
    );
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // Method will be called from every widgets which needs a localized text.
  String? trans(String key) => _localizedStrings[key];
}

/*
LocalizationsDelegate is a factory for a set of localized resources.
The localized strings will be gotten in an AppLocalizations object.
*/
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  // Include all supported language codes here.
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs.
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

/*
? Helper function to translate texts on Texts class.
*/
String translate(BuildContext context, String text) {
  return AppLocalizations.of(context)!.trans(text)!;
}

/*
? Helper class that access the texts in json format.
* Find the texts to translate in /assets/lang/.
*/
class Texts {
  static const String appName = 'Task List';

  // Intro Screen.
  static const String introSkip = 'introSkip';
  static const String introDone = 'introDone';
  static const String introWelcomeTitle = 'introWelcomeTitle';
  static const String introWelcomeMsg = 'introWelcomeMsg';
  static const String introEditTitle = 'introEditTitle';
  static const String introEditMsg = 'introEditMsg';
  static const String introDeleteTitle = 'introDeleteTitle';
  static const String introDeleteMsg = 'introDeleteMsg';
  static const String introPullRefreshTitle = 'introPullRefreshTitle';
  static const String introPullRefreshMsg = 'introPullRefreshMsg';

  // Task List Screen.
  static const String tasks = 'tasks';
  static const String loading = 'loading';
  static const String placeholderErrorIcon = 'placeholderErrorIcon';
  static const String placeholderErrorMsg = 'placeholderErrorMsg';
  static const String placeholderAllDoneIcon = 'placeholderAllDoneIcon';
  static const String placeholderAllDoneMsg = 'placeholderAllDoneMsg';

  // Add Task Form.
  static const String taskFormTitleAdd = 'taskFormTitleAdd';
  static const String taskFormTitleEdit = 'taskFormTitleEdit';
  static const String taskFormError = 'taskFormError';
  static const String taskFormButton = 'taskFormButton';

  // Action Sheet.
  static const String actionConfirmYes = 'actionConfirmYes';
  static const String actionConfirmNo = 'actionConfirmNo';

  // Action Sheet Delete.
  static const String actionDeleteTitle = 'actionDeleteTitle';
  static const String actionDeleteMsg = 'actionDeleteMsg';
  static const String actionDeleteSnackbar = 'actionDeleteSnackbar';
}
