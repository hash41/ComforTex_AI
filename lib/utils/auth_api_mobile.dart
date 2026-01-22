import 'dart:convert';

import 'package:comfortex_ai/exception/server_exception.dart';
import 'package:comfortex_ai/exception/unauthorized_exception.dart';
import 'package:comfortex_ai/utils/auth_api_v2.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

class AuthApiMobile extends AuthApiv2 {
  AuthApiMobile() {
    if (url == '') {
      throw ArgumentError('The application on mobile'
          ' requires an absolute URL');
    }
  }

  @override
  Future<List<String>> login(String username, String password) async {
    final uri =
    getUrl('/comfortex_ai/api/auth/login');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    if(kDebugMode) {
      print(response.body);
    }
    AuthApiv2.statusCodeParser(response);
    final data = jsonDecode(response.body) as Map<String?, dynamic>;
    final jwtToken = data['jwtToken'] as String?;
    if(jwtToken == null) {
      throw ServerException('We didn\'t receive a login token from the server');
    }
    final result = groupsFrom(jwtToken);
    //We don't want to write to storage if it is an admin for now..
    //Later we could remove admin role completely and keep user ..
    if(result.contains('admin')) {
      return result;
    }
    try {
      await storage.write(
        key: 'jwtToken',
        value: jwtToken,
      );
    } catch (e, st) {
      if (kDebugMode) {
        print('ERROR _storage.write method (because its an http web)');
      }
    }
    //mobile specific behaviour
    await _getAndStoreRt(response);
    return result;
  }

  ///Right now we expect a cookie from the login but refresh() endpoint sends
  /// RT  as json.. Mobile specific method
  Future<void> _getAndStoreRt(http.Response response) async {
    final cookies = response.headers['set-cookie'];
    String? refreshToken;
    if (cookies == null) {
      if (kDebugMode) {
        print('cookie is null, trying to parse body');
      }
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      refreshToken = json['refreshToken'] as String?;
    } else {
      if (kDebugMode) {
        print('Refresh Token sent via cookie :)');
      }
      refreshToken = cookies.split(';').first.split('=').last;
    }
    if (refreshToken == null) {
      throw UnauthorizedException(
          'No refresh token in the response from server');
    }
    if (kDebugMode) {
      print('saving the RT: $refreshToken');
    }
    await storage.write(
      key: 'refreshToken',
      value: refreshToken,
    );
    final time =
        DateTime.now().add(const Duration(minutes: 5)).toIso8601String();
    await storage.write(
      key: 'expiry',
      value: time,
    );
  }

  ///Refresh the jwtToken and refreshToken using the refreshToken
  ///Mobile method
  @override
  Future<List<String>> refresh() async {
    final rt = await storage.read(key: 'refreshToken');
    if (rt == null) throw Exception('App error: refresh token is null');
    final uri = getUrl('/comfortex_ai/api/auth/refresh');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': rt}),
    );
    AuthApiv2.statusCodeParser(response); //throws exception on 4xx and 5xx
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final jwtToken = data['jwtToken'] as String?;
    //The browser automatically sets a cookie for refresh parameter in web
    if (jwtToken == null) {
      throw ServerException("Didn't receive a JWT access token from the server");
    }
    await storage.write(
      key: 'jwtToken',
      value: jwtToken,
    );
    await _getAndStoreRt(response);
    final result = groupsFrom(jwtToken);
    if (kDebugMode) {
      print('Group returned from refresh: $result');
    }
    return result;
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: 'jwtToken');
    if (token == null || token.isEmpty) {
      return false;
    }
    if (Jwt.isExpired(token)) {
            final refreshTokenExpiry = await storage.read(key: 'expiry') ??
                DateTime.now().toIso8601String();
            DateTime rte = DateTime.tryParse(refreshTokenExpiry)!;
            if (rte.compareTo(DateTime.now()) > 0) {
                try {
                  await refresh();
                  return true;
                } on UnauthorizedException catch (e) {
                  return false;
                }
            } else {
              return false;
            }
    }
    ///JWT isn't expired
    return true;
  }

  @override
  Future<void> logout() async {
    await storage.delete(key: 'jwtToken');
    Uri uri;
    Object? body;
    uri = getUrl('/comfortex_ai/api/auth/logout');
    final rt = await storage.read(key: 'refreshToken');
    body = jsonEncode({'refreshToken': rt});
    await storage.delete(key: 'refreshToken');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    AuthApiv2.statusCodeParser(response);
  }

  @override
  Uri getUrl(String expansion) {
    return Uri.parse(url + expansion);
  }
}
