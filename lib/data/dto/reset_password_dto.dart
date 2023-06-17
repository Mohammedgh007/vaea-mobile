
/// It stores the fields that stores the body of rest api request that is sent
/// for resetting the password.
class ResetPasswordDto {

  String emailAddress;
  String oldPassword;
  String newPassword;

  ResetPasswordDto({
    required this.emailAddress,
    required this.oldPassword,
    required this.newPassword
  });

  /// It is used to convert the fields to map in order to be converted as a json object.
  Map<String, dynamic> getFieldMap() {
    return {
      "email_address": emailAddress,
      "old_password": oldPassword,
      "new_password": newPassword
    };
  }
}