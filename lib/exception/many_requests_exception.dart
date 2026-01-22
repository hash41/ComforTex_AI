class ManyRequestsException implements Exception {
  ManyRequestsException(String message): this._message=message;
  final String _message;
  @override
  String toString() {
    return 'Many requests exception: $_message';
  }
  String get message {
    return _message;
  }
}