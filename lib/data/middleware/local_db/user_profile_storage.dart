
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaea_mobile/data/dto/save_user_profile_dto.dart';

/// It stores the user preference for profile info.
class UserProfileStorage {

  static const String firstNameKey = "FIRST_NAME";
  static const String lastNameKey = "LAST_NAME";
  static const String emailAddressKey = "EMAIL_ADDRESS";
  static const String profileImageUrlKey = "PROFILE_IMAGE_URL";
  static const String languageKey = "NOTIFY_LANGUAGE";

  /* Ensuring Singleton */
  static late final UserProfileStorage _instance = UserProfileStorage._();
  factory UserProfileStorage() {
    return _instance;
  }
  /* Ensuring Singleton */

  UserProfileStorage._() {

  }


  /// It loads the user profile info from the local storage.
  Future<Map<String, dynamic>?> loadUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    if (!prefs.containsKey(firstNameKey)) { // either all keys or none exist
      return null; // there is no saved profile
    } else {
      return {
        "first_name": prefs.getString(firstNameKey),
        "last_name": prefs.getString(lastNameKey),
        "email_address": prefs.getString(emailAddressKey),
        "profile_image": prefs.getString(profileImageUrlKey),
        "user_lang": prefs.getString(languageKey)
      };
    }
  }


  /// It updates or saves new user profile info in the local storage.
  Future<void> saveProfileImage(SaveUserProfileDto requestDto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(firstNameKey, requestDto.firstName);
    prefs.setString(lastNameKey, requestDto.lastName);
    prefs.setString(emailAddressKey, requestDto.emailAddress);
    prefs.setString(profileImageUrlKey, requestDto.profileImageUrl);
    prefs.setString(languageKey, requestDto.userLanguage);
  }


  /// It deletes the profile info from the local storage.
  Future<void> deleteUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(firstNameKey)) { // either all keys or none exist
      Future.wait([
        prefs.remove(firstNameKey),
        prefs.remove(lastNameKey),
        prefs.remove(emailAddressKey),
        prefs.remove(profileImageUrlKey),
        prefs.remove(languageKey)
      ]);
    }
  }
}
