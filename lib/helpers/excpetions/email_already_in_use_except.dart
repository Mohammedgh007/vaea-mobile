
/// It represents the error when a user tries to sign up with an existing email.
class EmailAlreadyInUseException implements Exception {

  String msg;
  EmailAlreadyInUseException({required this.msg});
}