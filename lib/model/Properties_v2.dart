import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PropertiesV2 {

  dynamic _fit;
  dynamic _workIntensity;
  dynamic _purpose;
  dynamic _layers;
  dynamic _scenario;
  dynamic _temperature;
  dynamic _humidity;
  http.Response? response;
  late Uri _uri;

  PropertiesV2() {
    const base = const String.fromEnvironment('base_url');
    bool _https = const bool.fromEnvironment('https', defaultValue: true);
    final _prefix = _https ? 'https' : 'http';
    String _url = base.isNotEmpty ? '$_prefix:\\' '\\$base' : '';
    this._uri = Uri.parse('$_url/comfortex_ai/api/options');
  }

  Future<bool> generateProperties() async {
    try {
      response = await http.get(_uri);
      final result = json.decode(response!.body) as Map<String, dynamic>;
      //Convert from a unknown type to map of key String: value List<String>
      //Doesn't function on web..
      result.forEach((key, value) {
        // value is a List in your JSON
        result[key] = (value as List).map((e) => e.toString()).toList();
      });
      _fit = result['fit'];
      _workIntensity = result['workIntensity'] as List;
      _purpose = result['purpose'] as List;
      _layers = result['layers'] as List;
      _scenario = result['scenario'] as List;
      _temperature = result['temperature'] as List;
      _humidity = result['humidity'] as List;
      return true;
    } catch (e) {
      if(kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  get fitList {
    return _fit;
  }
  get workIntensityList {
    return _workIntensity;
  }
  get purposeList {
    return _purpose;
  }
  get layersList {
    return _layers;
  }
  get scenarioList {
    return _scenario;
  }
  get temperatureList {
    return _temperature;
  }
  get humidityList {
    return _humidity;
  }

  @override
  String toString() {
    var result = _fit?.toString() ?? '';
    result += _workIntensity?.toString() ?? '';
    result += _purpose?.toString() ?? '';
    result += _layers?.toString() ?? '';
    result += _scenario?.toString() ?? '';
    result += _temperature?.toString() ?? '';
    result += _humidity?.toString() ?? '';
    return result;
  }
}