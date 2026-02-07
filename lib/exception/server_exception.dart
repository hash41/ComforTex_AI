/// ServerException help you with the 500 errors
class ServerException implements Exception {
  /// Normal constructor of an exception
  ServerException(String message): _message=message;
  final String _message;
  @override
  String toString() {
    return 'Server exception: $_message';
  }
  /// Message variable getter
  String get message {
    return _message;
  }
}
