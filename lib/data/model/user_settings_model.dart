
/// It represents the properties of user settings
class UserSettingsModel {

  /// It must be either ar, en, or null for unset value which indicates the user is new
  late String? languageCode;
  /// It must be SAR
  late String currency;

  /// It constructs the instance based on the decoded map in UserSettingsRepo.loadSettings
  UserSettingsModel(Map<String, dynamic> decodedMap) {
    languageCode = decodedMap["languageCode"];
    currency = decodedMap["currency"];
  }
}