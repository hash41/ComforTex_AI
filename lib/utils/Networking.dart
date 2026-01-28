import 'dart:async';
import 'dart:convert';
import 'package:comfortex_ai/model/Properties_v2.dart';
import 'package:comfortex_ai/model/ai_version.dart';
import 'package:comfortex_ai/model/prediction.dart';
import 'package:comfortex_ai/utils/auth_api_mobile.dart';
import 'package:comfortex_ai/utils/auth_api_v2.dart';
import 'package:comfortex_ai/utils/auth_api_web.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// A class to handle network requests
class Networking {
  Future<void> httpGet(PropertiesV2 properties) async {
    AuthApiv2 authApi;
    if (kIsWeb) {
      authApi = AuthApiWeb();
    } else {
      authApi = AuthApiMobile();
    }
    // If the server did return a 200 OK response,
    // then parse the JSON.
    try {
      if (AiVersionStore.instance.aiVersion == AiVersion.one)
      {
        final response =
            await authApi.get('/comfortex_ai/api/prediction/v1', properties);
        final result = json.decode(response.body) as Map<String, dynamic>;
        properties.prediction = Prediction.fromJson(result);
      } else
      {
        final response =
            await authApi.get('/comfortex_ai/api/prediction', properties);
        final result = json.decode(response.body) as Map<String, dynamic>;
        properties.prediction = Prediction.fromJson(result);
      }
    } on http.ClientException catch (e) {
      throw Exception('Could not connect to the server');
    }
    //todo: return this prediction object
  }
}
