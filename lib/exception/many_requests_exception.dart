/// A specific exception which is capable of telling us that the backend
/// denied our request because we sent many requests
class ManyRequestsException implements Exception {
  /// Normal Exception constructor
  ManyRequestsException(String message): _message=message;
  final String _message;
  @override
  String toString() {
    return 'Many requests exception: $_message';
  }
  /// Message variable getter
  String get message {
    return _message;
  }
}
