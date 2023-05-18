import 'package:flutter/cupertino.dart';
import 'package:vaea_mobile/data/middleware/local_db/user_settings_storage.dart';

import '../model/user_settings_model.dart';

/// It retrieves and updates the user settings from the database
class UserSettingsRepo {

  late UserSettingsStorage _storage;

  UserSettingsRepo() {
    _storage = UserSettingsStorage();
  }

  /// It loads the user settings from the local database.
  Future<UserSettingsModel> loadSettings() async {
    debugPrint("inn ${_storage.toString()}");
    Map<String, dynamic> decodedResult = await _storage.loadSettings();
    return UserSettingsModel(decodedResult);
  }


  /// It saves the user language into the local database and the server database.
  Future<void> updateUserLanguage(String languageIsoCode) async {
    await _storage.saveUserLanugage(languageIsoCode);
  }
}