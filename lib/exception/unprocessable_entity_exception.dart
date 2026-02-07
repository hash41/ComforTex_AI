/// An Exception which is very clear triggered by the AI when it receives a
/// request that cannot be processed
class UnprocessableEntityException implements Exception {
  /// Constructor
  UnprocessableEntityException(String message): _message=message;
  final String _message;
  @override
  String toString() {
    return 'Unprocessable entity exception: $_message';
  }
  /// Getter
  String get message {
    return _message;
  }
}
