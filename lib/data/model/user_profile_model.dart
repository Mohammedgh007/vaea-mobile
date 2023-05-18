
/// It represents the properties of the user profile.
class UserProfileModel {

  late String firstName;
  late String lastName;
  late String emailAddress;
  late String? profileImageUrl;
  /// It is either ar or en
  late String userLanguage;

  /// It constructs the instance based on the decoded map in profileRepo
  UserProfileModel.fromMap(Map<String, dynamic> decodedMap) {
    firstName = decodedMap["first_name"];
    lastName = decodedMap["last_name"];
    emailAddress = decodedMap["email_address"];
    if (decodedMap["profile_image"] == null || (decodedMap["profile_image"] as String).replaceAll(" ", "") == "") {
      profileImageUrl = null;
    } else {
      profileImageUrl = decodedMap["profile_image"];
    }

    userLanguage = decodedMap["user_lang"];
  }

  UserProfileModel({
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
      this.profileImageUrl,
    required this.userLanguage
      });
}