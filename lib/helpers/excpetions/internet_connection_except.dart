
/// It represents the error that is caused by poor internet connection.
class InternetConnectionException implements Exception {
  String msg;
  InternetConnectionException({required this.msg});
}