class EndpointNotFoundException implements Exception {
  EndpointNotFoundException(String message): this._message=message;
  final String _message;
  @override
  String toString() {
    return 'Endpoint not found exception: $_message';
  }
  String get message {
    return _message;
  }
}