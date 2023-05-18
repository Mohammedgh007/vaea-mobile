
/// It represents the error caused by calling a method that requires authenticated
/// state.
class NotSignedInException implements Exception {

  String msg;
  NotSignedInException({required this.msg});
}
