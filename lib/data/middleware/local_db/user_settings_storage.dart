import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// It stores the user preferences for language and other settings
class UserSettingsStorage {

  static const String languageKey = "LANG_ISO_CODE";

  /* Ensuring Singleton */
  static late final UserSettingsStorage _instance = UserSettingsStorage._();
  factory UserSettingsStorage() {
    return _instance;
  }
  /* Ensuring Singleton */

  UserSettingsStorage._() {

  }


  /// It loads the list of settings from the database.
  Future<Map<String, dynamic>> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    late String? languageCode;
    if(!prefs.containsKey(languageKey)) {
      languageCode = null;
    } else {
      languageCode = prefs.getString(languageKey);
    }

    return {
      "languageCode": languageCode,
      "currency": "SAR"
    };
  }


  /// It updates the language preference in the database
  /// @param selectedLangIsoCode must be either ar or en
  Future<void> saveUserLanugage(String selectedLangIsoCode) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(languageKey, selectedLangIsoCode);
  }


}