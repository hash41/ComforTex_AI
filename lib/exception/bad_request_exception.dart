class BadRequestException implements Exception {
  BadRequestException(String message): this._message=message;
  final String _message;
  @override
  String toString() {
    return 'Bad request exception: $_message';
  }
  String get message {
    return _message;
  }
}