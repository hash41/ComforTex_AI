/// class Exceptions triggered when trying to access an endpoint which is not
/// available on the backend or on the AI
class EndpointNotFoundException implements Exception {

  /// A Constructor, helps us set the message.
  EndpointNotFoundException(String message): _message=message;
  final String _message;
  @override
  String toString() {
    return 'Endpoint not found exception: $_message';
  }
  /// Message variable getter
  String get message {
    return _message;
  }
}
