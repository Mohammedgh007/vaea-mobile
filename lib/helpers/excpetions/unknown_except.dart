
/// This exception represents a propagated error whose cause is unknown.
class UnknownException implements Exception{

  String msg;
  UnknownException({required this.msg});
}