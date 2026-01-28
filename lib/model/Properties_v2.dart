import 'dart:convert';

import 'package:comfortex_ai/model/prediction.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

enum ShirtType { polo, t_shirt }

class PropertiesV2 {

  PropertiesV2() {
    const base = const String.fromEnvironment('base_url');
    bool _https = const bool.fromEnvironment('https', defaultValue: true);
    final _prefix = _https ? 'https' : 'http';
    String _url = base.isNotEmpty ? '$_prefix:\\' '\\$base' : '';
    this._uri = Uri.parse('$_url/comfortex_ai/api/options');
  }

  ShirtType? _shirtType;
  String? _material;
  int? _fabricNum;
  String? _fit;
  String? _layers;
  String? _workIntensity;
  String? _purpose;
  String? _scenario;
  int? _temperature = 50;
  int? _humidity = 60;
  Prediction? _prediction;
  int min_temperature = 0;
  int max_temperature = 100;
  int min_humidity = 30;
  int max_humidity = 90;

  late List<String> _fitGroup;
  late List<String> _workIntensityGroup;
  late List<String> _purposeGroup;
  late List<String> _layersGroup;
  late List<String> _scenarioGroup;
  late List<int> _temperatureGroup;
  late List<int> _humidityGroup;
  http.Response? response;
  late Uri _uri;

  bool checkProperties() {
    if (_shirtType == null ||
        _material == null ||
        _fabricNum == null ||
        _fit == null ||
        _layers == null ||
        _workIntensity == null ||
        _purpose == null ||
        _scenario == null) {
      return false;
    }
    return true;
  }

  Map<String, String?> toJson() {
    return {
      'fabricNum': fabricNum?.toString(),
      'fit': fit,
      'layers': layers?.toLowerCase() == 'one' ? '1' :
      layers?.toLowerCase() == 'two' ? '2'
          : '3',
      'workIntensity': workIntensity,
      'purpose': purpose,
      'scenario': scenario,
      'temperature': temperature.toString(),
      'humidity': humidity.toString()
    };
  }


  //PropertiesV1 in the backend are in lowercase, im aware of it
  bool generatePropertiesV1() {
    try {
      _fitGroup = ['fit', 'loose'];
      _workIntensityGroup = [
        'low',
        'moderate',
        'high',
      ];
      _purposeGroup = ['sport', 'protection'];
      _layersGroup = ['one', 'two'];
      _scenarioGroup = ['indoors', 'outdoors'];
      _temperatureGroup = [23, 25];
      min_temperature = _temperatureGroup[0];
      max_temperature = _temperatureGroup[1];
      _temperature = (_temperatureGroup[0] + _temperatureGroup[1]) ~/ 2;
      _humidityGroup = [50, 65];
      _humidity = (_humidityGroup[0] + _humidityGroup[1]) ~/ 2;
      min_humidity = _humidityGroup[0];
      max_humidity = _humidityGroup[1];
      return true;
    } catch (e) {
      return false;
    }
  }

  //These PropertiesV2 have first letter in uppercase format, im aware of it
  bool generatePropertiesV2() {
    try {
      _fitGroup = ['Tight', 'Loose'];
      _workIntensityGroup = [
        'Light',
        'Moderate',
        'High',
      ];
      _purposeGroup = ['Sport', 'Protection'];
      _layersGroup = ['One', 'Two', 'Three'];
      _scenarioGroup = ['Indoors', 'Outdoors'];
      _temperatureGroup = [23, 25];
      min_temperature = _temperatureGroup[0];
      max_temperature = _temperatureGroup[1];
      _temperature = (_temperatureGroup[0] + _temperatureGroup[1]) ~/ 2;
      _humidityGroup = [50, 65];
      _humidity = (_humidityGroup[0] + _humidityGroup[1]) ~/ 2;
      min_humidity = _humidityGroup[0];
      max_humidity = _humidityGroup[1];
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> generatePropertiesDynamic() async {
    try {
      response = await http.get(_uri);
      final result = json.decode(response!.body) as Map<String, dynamic>;
      //Convert from a unknown type to map of key String: value List<String>
      //Doesn't function on web..
      result.forEach((key, value) {
        // value is a List in your JSON
        result[key] = (value as List).map((e) => e.toString()).toList();
      });
      _fitGroup = result['fit'] as List<String>;
      _workIntensityGroup = result['workIntensity'] as List<String>;
      _purposeGroup = result['purpose'] as List<String>;
      _layersGroup = result['layers'] as List<String>;
      _scenarioGroup = result['scenario'] as List<String>;
      var temp = result['temperature'] as List<String>;
      _temperatureGroup = temp.map(int.parse).toList();
      _temperature = (_temperatureGroup[0] + _temperatureGroup[1]) ~/ 2;
      min_temperature = _temperatureGroup[0];
      max_temperature = _temperatureGroup[1];
      temp = result['humidity'] as List<String>;
      _humidityGroup = temp.map(int.parse).toList();
      _humidity = (_humidityGroup[0] + _humidityGroup[1]) ~/ 2;
      min_humidity = _humidityGroup[0];
      max_humidity = _humidityGroup[1];
      return true;
    } catch (e) {
      if(kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  List<dynamic> getProperties() {
      return [
        _shirtType?.name,
        _material,
        _fabricNum,
        _fit,
        _layers,
        _workIntensity,
        _purpose,
        _scenario,
        _temperature,
        _humidity
      ];
  }

  List<String> get fitList {
    return _fitGroup;
  }
  List<String> get workIntensityList {
    return _workIntensityGroup;
  }
  List<String> get purposeList {
    return _purposeGroup;
  }
  List<String> get layersList {
    return _layersGroup;
  }
  List<String> get scenarioList {
    return _scenarioGroup;
  }
  List<int> get temperatureList {
    return _temperatureGroup;
  }
  List<int> get humidityList {
    return _humidityGroup;
  }

  //We will allow null because its a nullable ..

  set material(String? material) {
    _material = material;
  }

  String? get material {
    return _material;
  }

  set fabricNum(int? fabricNum) {
    _fabricNum = fabricNum;
  }

  int? get fabricNum {
    return _fabricNum;
  }

  ShirtType? get shirtType {
    return _shirtType;
  }

  String? get fit {
    return _fit;
  }

  String? get layers {
    return _layers;
  }

  String? get workIntensity {
    return _workIntensity;
  }

  String? get purpose => _purpose;

  String? get scenario => _scenario;

  int? get temperature {
    return _temperature;
  }

  int? get humidity {
    return _humidity;
  }

  PropertiesV2 get properties {
    return this;
  }

  Prediction? get prediction {
    return _prediction;
  }

  set shirtType(ShirtType? shirtType) {
    _shirtType = shirtType;
  }

  set fit(String? fit) {
    _fit = fit;
  }

  set layers(String? layers) {
    _layers = layers;
  }

  set workIntensity(String? workIntensity) {
    _workIntensity = workIntensity;
  }

  set purpose(String? purpose) {
    _purpose = purpose;
  }

  set scenario(String? scenario) {
    _scenario = scenario;
  }

  set temperature(int? temperature) {
    if (temperature != null && temperature < min_temperature) {
      _temperature = min_temperature;
    } else if (temperature != null && temperature > max_temperature) {
      _temperature = max_temperature;
    } else {
      _temperature = temperature;
    }
  }

  set humidity(int? humidity) {
    if (humidity != null && humidity > max_humidity) {
      _humidity = max_humidity;
    } else if (humidity != null && humidity < min_humidity) {
      _humidity = min_humidity;
    } else {
      _humidity = humidity;
    }
  }

  set prediction(Prediction? prediction) {
    _prediction = prediction;
  }

  @override
  String toString() {
    String result;
    result = '$_fitGroup ';
    result += '$_workIntensityGroup ';
    result += '$_layersGroup ';
    result += '$_purposeGroup ';
    result += '$_scenarioGroup ';
    result += '$_temperatureGroup ';
    result += '$_humidityGroup ';
    result += _fit?.toString() ?? '';
    result += _workIntensity?.toString() ?? '';
    result += _purpose?.toString() ?? '';
    result += _layers?.toString() ?? '';
    result += _scenario?.toString() ?? '';
    result += _temperature?.toString() ?? '';
    result += _humidity?.toString() ?? '';
    return result;
  }
}