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
  /// performs a get operation with the help of the [AuthApiV2]
  Future<void> httpGet(PropertiesV2 propertiesRaw) async {
    AuthApiV2 authApi;
    http.Response response;
    var result = <String, dynamic>{};
    if (kIsWeb) {
      authApi = AuthApiWeb();
    } else {
      authApi = AuthApiMobile();
    }
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final propertiesJson = propertiesRaw.toJson();
    try {
      if (AiVersionStore.instance.aiVersion == AiVersion.one) {
        if (kDebugMode) {
          print(propertiesJson);
        }
        response = await authApi.get(
            '/comfortex_ai/api/prediction/v1', propertiesJson,);
        result = json.decode(response.body) as Map<String, dynamic>;
      } else if (AiVersionStore.instance.aiVersion ==
          AiVersion.twoDynamicProperties) {
        response = await authApi.get(
            '/comfortex_ai/api/prediction/vdyn', propertiesJson,);
        result = json.decode(response.body) as Map<String, dynamic>;
        propertiesRaw.prediction = Prediction.fromJson(result);
      } else {
        response =
            await authApi.get('/comfortex_ai/api/prediction', propertiesJson);
        result = json.decode(response.body) as Map<String, dynamic>;
      }
    } on http.ClientException {
      throw Exception('Could not connect to the server');
    } finally {
      propertiesRaw.prediction = Prediction.fromJson(result);
    }
    //TODO(Hash): return this prediction object
  }
}
