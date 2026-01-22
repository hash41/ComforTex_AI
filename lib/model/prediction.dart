import 'package:comfortex_ai/exception/server_exception.dart';
import 'package:flutter/material.dart';

///This class represents a prediction model based on conditions in Properties class.
class Prediction {
  /// Default constructor for the Prediction class.
  Prediction({
    String? thermal,
    String? moisture,
    String? comfort,
    // String? comfortAnalysis,
    Map<String, List<dynamic>>? keyFactors,
  })  : _thermal = thermal,
        _moisture = moisture,
        _comfort = comfort,
        // _comfortAnalysis = comfortAnalysis,
        _keyFactors = keyFactors;

  /// Creates a Prediction object from a JSON map.
  Prediction.fromJson(Map<String, dynamic> json) {

    _thermal = json['thermal_probability']?.toString();
    _moisture = json['moisture_probability']?.toString();
    _comfort = json['comfort_probability']?.toString();
    //_comfortAnalysis = json['comfortAnalysis'].toString();
    final factors = json['features_contribution']?.toString();
    if(_comfort ==null || _thermal == null || _moisture == null || factors == null) {
      throw ServerException('Couldn\'t do AI inference on the server');
    }
    for (String f in factors.split('\n')) {
      if (f.isNotEmpty) {
        final l = f.split(':');
        List<String> parsedValues = l[1].split(' - ');
        Icon icon;
        if (parsedValues[1] != null && parsedValues[1].contains('increase')) {
          icon = const Icon(
            Icons.arrow_upward_sharp,
            color: Colors.green,
            weight: 96,
            size: 32,
          );
        } else {
          icon = const Icon(
            Icons.arrow_downward_sharp,
            color: Colors.red,
            weight: 96,
            size: 32,
          );
        }
        final res = [
          parsedValues[0].trim().replaceAll('(', '').replaceAll(')', ''),
          icon,
        ];
        _keyFactors?[l[0].trim()] = res;
      }
    }
  }

  String? _thermal;
  String? _moisture;
  String? _comfort;
  //String? _comfortAnalysis;
  Map<String, List<dynamic>>? _keyFactors = {};

  set thermal(String? value) {
    thermal = value;
  }

  String? get thermal {
    return _thermal;
  }

  set moisture(String? value) {
    moisture = value;
  }

  String? get moisture {
    return _moisture;
  }

  set comfort(String? value) {
    comfort = value;
  }

  String? get comfort {
    return _comfort;
  }

  // set comfortAnalysis(String? value) {
  //   comfortAnalysis = value;
  // }
  // String? get comfortAnalysis {
  //   return _comfortAnalysis;
  // }
  //
  set keyFactors(Map<String, List<dynamic>>? value) {
    keyFactors = value;
  }

  Map<String, List<dynamic>>? get keyFactors {
    return _keyFactors;
  }
}
