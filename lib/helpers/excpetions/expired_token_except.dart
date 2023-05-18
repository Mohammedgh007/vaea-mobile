
/// It represents the error caused by using an authenticated http call with expired
/// token.
class ExpiredTokenException implements Exception {
  String msg;
  ExpiredTokenException({required this.msg});
}