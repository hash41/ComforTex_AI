class UnprocessableEntityException implements Exception {
  UnprocessableEntityException(String message): this._message=message;
  final String _message;
  @override
  String toString() {
    return 'Unprocessable entity exception: $_message';
  }
  String get message {
    return _message;
  }
}