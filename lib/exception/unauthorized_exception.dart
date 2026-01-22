class UnauthorizedException implements Exception {
  final String _message;
  UnauthorizedException(String message): this._message=message;
  String toString() {
    return 'Unauthorized exception: ' + _message;
  }
  String get message {
    return _message;
  }
}