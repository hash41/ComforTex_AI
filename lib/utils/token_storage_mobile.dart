// // import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// class SecureTokenStorage implements TokenStorage {
//   final _storage = const FlutterSecureStorage();
//
//   @override Future<void> save(String token) =>
//       _storage.write(key: 'jwt', value: token);
//
//   @override Future<String?> read() =>
//       _storage.read(key: 'jwt');
//
//   @override Future<void> clear() =>
//       _storage.delete(key: 'jwt');
// }
//
// // TokenStorage createTokenStorage() => SecureTokenStorage();
