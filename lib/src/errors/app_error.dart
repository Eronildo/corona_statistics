abstract class AppError implements Exception {
  String get message;
}

class ServerError extends AppError {
  final String message;
  ServerError({this.message = ''});
}
