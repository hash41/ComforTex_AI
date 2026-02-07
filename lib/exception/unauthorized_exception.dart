/// An exception rare one triggered when the user session is over and needs to
/// reauthenticate
class UnauthorizedException implements Exception {
  /// Constructor
  UnauthorizedException(String message): _message=message;
  final String _message;
  @override
  String toString() {
    return 'Unauthorized exception: $_message';
  }

  /// Getter
  String get message {
    return _message;
  }
}
