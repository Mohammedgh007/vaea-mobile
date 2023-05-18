
/// It stores the fields that stores the body of rest api request that is sent
/// for signing the user in.
class SignInDto {

  String emailAddress;
  String password;

  SignInDto({
    required this.emailAddress,
    required this.password
  });

  /// It is used to convert the fields to map in order to be converted as a json object.
  Map<String, dynamic> getFieldMap() {
    return {
      "email_address": emailAddress,
      "password": password,
    };
  }
}