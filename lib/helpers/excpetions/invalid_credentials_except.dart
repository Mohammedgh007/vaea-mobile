
/// It represents the error that occurs when a user tries to sign in with
/// wrong credentials.
class InvalidCredentialsException implements Exception {

  String msg;
  InvalidCredentialsException({required this.msg});
}