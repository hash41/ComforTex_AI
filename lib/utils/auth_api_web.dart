import 'dart:convert';

import 'package:comfortex_ai/exception/server_exception.dart';
import 'package:comfortex_ai/exception/unauthorized_exception.dart';
import 'package:comfortex_ai/utils/auth_api_v2.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

class AuthApiWeb extends AuthApiv2 {

  @override
  Future<List<String>> login(String username, String password) async {
    final uri =
    getUrl('/comfortex_ai/api/auth/login');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    ).timeout(const Duration(seconds: 15));
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
    return result;
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: 'jwtToken');
    if (token == null || token.isEmpty) {
      return false;
    }
    if (Jwt.isExpired(token)) {
      {
        try {
          if (kDebugMode) {
            print('calling refresh from isLoggedIn() on web');
          }
          await refresh();
          return true;
        } on UnauthorizedException catch (e) {
          //Other exceptions should propagate
          return false;
        }
      }
    }

    ///JWT isn't expired
    return true;
  }

  @override
  Future<List<String>> refresh() async {
    final uri = getUrl('/comfortex_ai/api/auth/refreshweb');
    final response = await http.post(
      uri,
    ).timeout(const Duration(seconds: 15));
    if (kDebugMode) {
      print(response.statusCode);
    }
    AuthApiv2.statusCodeParser(
      response,
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final jwtToken = data['jwtToken'] as String?;
    if (jwtToken != null) {
      await storage.write(
        key: 'jwtToken',
        value: jwtToken,
      );
      return groupsFrom(jwtToken);
    } else {
      throw UnauthorizedException('Server sent an empty jwt token');
    }
  }

  @override
  Future<void> logout() async {
    await storage.delete(key: 'jwtToken');
    Uri uri;
    uri = getUrl('/comfortex_ai/api/auth/logoutweb');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    AuthApiv2.statusCodeParser(response);
  }

  ///The web version of getUrl should enable building relative and absolute url
  @override
  Uri getUrl(String expansion) {
    if (url.isEmpty) {
      Uri uri = Uri.parse(expansion);
      Uri result = uri.replace(scheme: super.prefix);
      return result;
    }
    return Uri.parse(url + expansion);
  }
}
