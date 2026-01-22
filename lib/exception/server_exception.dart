class ServerException implements Exception {
  final String _message;
  ServerException(String message): this._message=message;
  String toString() {
    return 'Server exception: ' + _message;
  }
  String get message {
    return _message;
  }
}