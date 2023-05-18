
/// It represents the error when a user accesses a screen somehow in a illegal way
/// that include un-authorized access or invalid page (like non-existing apartment page).
class InvalidScreenAccessException implements Exception {
  String msg;
  InvalidScreenAccessException({required this.msg});
}