import 'dart:convert';

import 'package:comfortex_ai/model/prediction.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// ShirtType can be an enum
enum ShirtType {
  /// POLO
  polo,

  /// T-SHIRT has to be in the non camelcase format because the backend expects
  /// it this way
  t_shirt,
}

/// Properties in a new version, instead of using enum we are initializing Lists
///
class PropertiesV2 {
  /// Constructor capable of helping with the {fromEnvironment} variables
  /// required for further networking. Although the Properties class is not
  /// mainly about networking
  PropertiesV2() {
    const base = String.fromEnvironment('base_url');
    const https = bool.fromEnvironment('https', defaultValue: true);
    const prefix = https ? 'https' : 'http';
    final url = base.isNotEmpty ? '$prefix:\\' '\\$base' : '';
    _uri = Uri.parse('$url/comfortex_ai/api/options');
  }

  ///Attributes
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

  /// minimum temperature helps with building the UI of the temperature slider
  int minTemperature = 0;

  /// maximum temperature helps with building the UI of the temperature slider
  int maxTemperature = 100;

  /// minimum humidity helps with building the UI of the temperature slider
  int minHumidity = 30;

  /// maximum humidity helps with building the UI of the temperature slider
  int maxHumidity = 90;

  /// List of property group -> values
  late List<String> _fitGroup;
  late List<String> _workIntensityGroup;
  late List<String> _purposeGroup;
  late List<String> _layersGroup;
  late List<String> _scenarioGroup;
  late List<int> _temperatureGroup;
  late List<int> _humidityGroup;
  late http.Response? _response;
  late Uri _uri;

  /// Verify that a null values doesn't pass into later stages when we need to
  /// send these properties to backend
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

  ///JSON representation of {@Properties}
  Map<String, String?> toJson() {
    final propertiesMap = <String, String?>{};
    propertiesMap['Fabric_id'] = fabricNum?.toString();
    propertiesMap['Garment_fit'] = fit;
    if (layers == 'one' || layers == 'One') {
      propertiesMap['Garment_layer'] = '1';
    } else if (layers == 'two' || layers == 'Two') {
      propertiesMap['Garment_layer'] = '2';
    } else {
      propertiesMap['Garment_layer'] = '3';
    }
    propertiesMap['Work_intensity'] = workIntensity;
    propertiesMap['Garment_purpose'] = purpose;
    propertiesMap['Garment_scenario'] = scenario;
    propertiesMap['Env_temperature'] = temperature.toString();
    propertiesMap['Env_humidity'] = humidity.toString();
    return propertiesMap;
    // OR
    // return {
    //   'Fabric_id': fabricNum?.toString(),
    //   'Garment_fit': fit,
    //   'Garment_layer': layers == 'one' || layers == 'One'? '1' :
    //   layers == 'two' || layers == 'Two' ? '2'
    //       : '3',
    //   'Work_intensity': workIntensity,
    //   'Garment_purpose': purpose,
    //   'Garment_scenario': scenario,
    //   'Env_temperature': temperature.toString(),
    //   'Env_humidity': humidity.toString(),
    // };
  }

  ///PropertiesV1 in the backend are in lowercase, im aware of it
  ///Properties values generator
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
      minTemperature = _temperatureGroup[0];
      maxTemperature = _temperatureGroup[1];
      _temperature = (_temperatureGroup[0] + _temperatureGroup[1]) ~/ 2;
      _humidityGroup = [50, 65];
      _humidity = (_humidityGroup[0] + _humidityGroup[1]) ~/ 2;
      minHumidity = _humidityGroup[0];
      maxHumidity = _humidityGroup[1];
      return true;
    } on Exception {
      return false;
    }
  }

  //These PropertiesV2 have first letter in uppercase format, im aware of it
  ///Properties values generator
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
      minTemperature = _temperatureGroup[0];
      maxTemperature = _temperatureGroup[1];
      _temperature = (_temperatureGroup[0] + _temperatureGroup[1]) ~/ 2;
      _humidityGroup = [50, 65];
      _humidity = (_humidityGroup[0] + _humidityGroup[1]) ~/ 2;
      minHumidity = _humidityGroup[0];
      maxHumidity = _humidityGroup[1];
      return true;
    } on Exception {
      return false;
    }
  }

  /// Properties values generator
  /// Dynamic
  Future<bool> generatePropertiesDynamic() async {
    try {
      _response = await http.get(_uri);
      final result = json.decode(_response!.body) as Map<String, dynamic>;
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
      minTemperature = _temperatureGroup[0];
      maxTemperature = _temperatureGroup[1];
      temp = result['humidity'] as List<String>;
      _humidityGroup = temp.map(int.parse).toList();
      _humidity = (_humidityGroup[0] + _humidityGroup[1]) ~/ 2;
      minHumidity = _humidityGroup[0];
      maxHumidity = _humidityGroup[1];
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  ///A list representation of the values of the properties
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
      _humidity,
    ];
  }

  /// Getter of the [_fitGroup] which is the values under the key fit
  List<String> get fitList {
    return _fitGroup;
  }

  /// Getter of the [_workIntensityGroup] which is the values under the key
  /// workIntensity
  List<String> get workIntensityList {
    return _workIntensityGroup;
  }

  /// Getter of the [_purposeGroup] which is the values under the key purpose
  List<String> get purposeList {
    return _purposeGroup;
  }

  /// Getter of the [_layersGroup] which is the values under the key layers
  List<String> get layersList {
    return _layersGroup;
  }

  /// Getter of the [_scenarioGroup] which is the values under the key scenario
  List<String> get scenarioList {
    return _scenarioGroup;
  }

  /// Getter of the [_temperatureGroup] which is the values under the key
  /// min-max temperature
  List<int> get temperatureList {
    return _temperatureGroup;
  }

  /// Getter of the [_humidityGroup] which is the values under the key humidity
  /// min-max
  List<int> get humidityList {
    return _humidityGroup;
  }

  ///Getter of the [_fabricNum] value
  int? get fabricNum {
    return _fabricNum;
  }

  ///Getter of the [_shirtType] value
  ShirtType? get shirtType {
    return _shirtType;
  }

  ///Getter of the [_fit] value
  String? get fit {
    return _fit;
  }

  ///Getter of the [_layers] value
  String? get layers {
    return _layers;
  }

  ///Getter of the [_workIntensity] value
  String? get workIntensity {
    return _workIntensity;
  }

  ///Getter of the [_purpose] value
  String? get purpose => _purpose;

  ///Getter of the [_scenario] value
  String? get scenario => _scenario;

  ///Getter of the [_temperature] value
  int? get temperature {
    return _temperature;
  }

  ///Getter of the [_humidity] value
  int? get humidity {
    return _humidity;
  }

  /// Getter of the [_prediction] object
  Prediction? get prediction {
    return _prediction;
  }

  /// Getter of the [_material] value
  String? get material {
    return _material;
  }
  //We will allow null because its a nullable ..

  ///Setters
  set material(String? material) {
    _material = material;
  }

  set fabricNum(int? fabricNum) {
    _fabricNum = fabricNum;
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
    if (temperature != null && temperature < minTemperature) {
      _temperature = minTemperature;
    } else if (temperature != null && temperature > maxTemperature) {
      _temperature = maxTemperature;
    } else {
      _temperature = temperature;
    }
  }

  set humidity(int? humidity) {
    if (humidity != null && humidity > maxHumidity) {
      _humidity = maxHumidity;
    } else if (humidity != null && humidity < minHumidity) {
      _humidity = minHumidity;
    } else {
      _humidity = humidity;
    }
  }

  set prediction(Prediction? prediction) {
    _prediction = prediction;
  }

  ///ToString override
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
