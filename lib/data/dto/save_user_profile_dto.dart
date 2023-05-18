
/// It stores the fields that is used to store user profile info locally.
class SaveUserProfileDto {

  String firstName;
  String lastName;
  String emailAddress;
  /// If there is not profile image, then assigns it to ""
  String profileImageUrl;
  /// It is either ar or en
  String userLanguage;

  SaveUserProfileDto({
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.profileImageUrl,
    required this.userLanguage
  });
}

