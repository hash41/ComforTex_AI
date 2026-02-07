// // token_storage_web.dart
// import 'dart:html' as html;
// import 'token_storage.dart';
//
// class WebTokenStorage implements TokenStorage {
//   @override Future<void> save(String token) async {
//     html.window.localStorage['jwt'] = token;
//   }
//
//   @override Future<String?> read() async {
//     return html.window.localStorage['jwt'];
//   }
//
//   @override Future<void> clear() async {
//     html.window.localStorage.remove('jwt');
//   }
// }
//
// TokenStorage createTokenStorage() => WebTokenStorage();
