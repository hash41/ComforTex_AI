import 'dart:convert';

import 'package:comfortex_ai/exception/bad_request_exception.dart';
import 'package:comfortex_ai/exception/endpoint_not_found_exception.dart';
import 'package:comfortex_ai/exception/many_requests_exception.dart';
import 'package:comfortex_ai/exception/server_exception.dart';
import 'package:comfortex_ai/exception/unauthorized_exception.dart';
import 'package:comfortex_ai/exception/unprocessable_entity_exception.dart';
import 'package:comfortex_ai/utils/auth_api_mobile.dart';
import 'package:comfortex_ai/utils/auth_api_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

///Abstract class {AuthApi} to be extended in 2 web and mobile version.
abstract class AuthApiV2 {
  /// Constructor fetches [_baseUrl], [_https], [_prefix], and [_url]
  AuthApiV2() {
    _baseUrl = const String.fromEnvironment('base_url');
    _https = const bool.fromEnvironment('https', defaultValue: true);
    _prefix = _https ? 'https' : 'http';
    _url = _baseUrl.isNotEmpty ? '$_prefix:\\' '\\$_baseUrl' : '';
  }

  /// CONST VALUES
  /// String displayed on bad request
  static const String BAD_REQUEST =
      'Your input has passed primary validation but is incorrect.';
  /// String displayed on failed auth
  static const String FAILED_AUTHENTICATION = 'Authentication failed.';
  /// String displayed when the user hits a 404
  static const String ENDPOINT_NOT_FOUND = 'Endpoint not found.';
  /// String displayed on AI unprocessable request
  static const String UNPROCESSABLE_REQUEST =
      'The AI could not understand your request.';
  /// String displayed on doing 5 simultaneous logins
  static const String MANY_SIMULTANIOUS_AUTHENTICATIONS =
      'Many requests sent, slow down';
  /// String displayed on 500 error
  static const String SERVER_ERROR = 'We encountered an error ..server side..';
  late String _url;
  late String _baseUrl;
  late bool _https;
  late String _prefix;
  final _storage = const FlutterSecureStorage();

  /// login method implemented in 2 versions [AuthApiWeb], [AuthApiMobile]
  Future<List<String>> login(String username, String password);

  ///Refresh the jwtToken (and Refresh token.. different endpoints and
  ///implementations depending on OS)
  Future<List<String>> refresh();

  /// Return groups currently in the stored token
  Future<List<String>> currentGroups() async {
    final token = await _storage.read(key: 'jwtToken');
    if (token == null) return <String>[];
    return groupsFrom(token);
  }

  ///Abstract method, it will defer between mobile and web, so 2 implementations
  ///are required .
  Future<bool> isLoggedIn();

  /// Make an authenticated GET
  Future<http.Response> get(
      String path, Map<String, String?> jsonProperties,) async {
    // Uri uri;
    final url1 = getUrl(path);
    Uri uri;
    uri = url1.replace(queryParameters: jsonProperties);
    if (kDebugMode) {
      print(uri);
    }
    if (await isLoggedIn()) {
      final token = await _storage.read(key: 'jwtToken');
      final result = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );
      statusCodeParser(result);
      return result;
    } else {
      throw UnauthorizedException('Not authenticated');
    }
  }

  ///The logout endpoint called.
  Future<void> logout();

  /// returns if the authenticator is a user or admin
  List<String> groupsFrom(String token) {
    final payload = Jwt.parseJwt(token);
    // Standard MP JWT groups claim
    final g = payload['groups'];
    if (g is List) return g.cast<String>();
    return <String>[];
  }

  /// refactoring the use of status code..
  static void statusCodeParser(http.Response response) {
    final statusCode = response.statusCode;
    String? message;
    if (kDebugMode) {
      print(statusCode);
    }
    try {
      final body = jsonDecode(response.body) as Map<String?, dynamic>;
      message = body['errorMessage'] as String?;
    } on Exception {
      if (kDebugMode) {
        print('received a non JSON response');
      }
    }
    switch (statusCode) {
      case < 300 && > 199:
        {
          return;
        }
      case 400:
        {
          if (message != null && message.isNotEmpty) {
            throw BadRequestException(message);
          }
          throw BadRequestException(BAD_REQUEST);
        }
      case 401:
        {
          if (message != null && message.isNotEmpty) {
            throw UnauthorizedException(message);
          }
          throw UnauthorizedException(FAILED_AUTHENTICATION);
        }
      case 404:
        {
          if (kDebugMode) {
            print(response.body);
          }
          throw EndpointNotFoundException(ENDPOINT_NOT_FOUND);
        }
      case 422:
        {
          {
            if (kDebugMode) {
              print(response.body);
            }
            if (message != null && message.isNotEmpty) {
              throw UnprocessableEntityException(message);
            }
            throw UnprocessableEntityException(UNPROCESSABLE_REQUEST);
          }
        }
      case 429:
        {
          if (message != null && message.isNotEmpty) {
            throw ManyRequestsException(message);
          }
          throw ManyRequestsException(MANY_SIMULTANIOUS_AUTHENTICATIONS);
        }
      case 500:
        {
          if (kDebugMode) {
            print(response.body);
          }
          throw ServerException(SERVER_ERROR);
        }
    }
    if (kDebugMode) {
      print(response.body);
    }
    throw Exception('');
  }

  ///Builds URI based on url provided at class instantiation. Should be modified
  ///because the url on web is '' . On mobile it should not be empty.. Thus
  ///this method is platform specific..
  Uri getUrl(String expansion);

  ///Getters & setters
  String get prefix {
    return _prefix;
  }

  /// A getter: returns the backend url
  String get url {
    return _url;
  }

  /// A getter: returns the secure storage instance
  FlutterSecureStorage get storage {
    return _storage;
  }
}
