
import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/model/user_settings_model.dart';
import 'package:vaea_mobile/data/repo/user_settings_repo.dart';

/// It is the BloC component for accessing the user settings in the view.
class UserSettingsProvider extends ChangeNotifier {

  UserSettingsModel? userSettingsModel;
  final UserSettingsRepo _repo = UserSettingsRepo();

  /// It lets the repository to load the user settings.
  Future<void> loadSettings() async{
    userSettingsModel = await _repo.loadSettings();
    notifyListeners();
  }


  /// It changes the default user language.
  /// @pre-condition: userSettingsModel must be initialized.
  void changeUserLanguage(String selectedIsoCodeLanguage) {
    _repo.updateUserLanguage(selectedIsoCodeLanguage);
    userSettingsModel?.languageCode = selectedIsoCodeLanguage;
    notifyListeners();
  }

}