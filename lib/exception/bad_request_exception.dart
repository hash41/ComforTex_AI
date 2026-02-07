/// Class Exceptions triggered on a return type : bad request (401)
class BadRequestException implements Exception {
  /// Constructor
  BadRequestException(String message): _message=message;
  final String _message;
  @override
  String toString() {
    return 'Bad request exception: $_message';
  }

  /// Message variable getter
  String get message {
    return _message;
  }
}
