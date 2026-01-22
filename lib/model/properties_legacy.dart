//Todo: temperature only 20. humidity only 50 layers only 1 and scenario only indoors

import 'package:comfortex_ai/model/prediction.dart';
import 'package:comfortex_ai/model/properties.dart';

/// the Fit enum  and Layers now are used for choice making which updates our
/// screen based on the choice
enum Fit { fit, loose }

///enum Layers which are now used for choice making and updating your screen.
enum Layers { one, two }

///enums which are now used for choice making and updating our screen.
enum WorkIntensity { low, moderate, high }

///enums which are now used for choice making and updating your screen.
enum Purpose { sport, protection }

///enums which are now used for choice making and updating our screen.
enum Scenario { indoors, outdoors }

///Properties to be built..
class PropertiesLegacy extends Properties<ShirtType, Fit, Layers, WorkIntensity,
    Purpose, Scenario> {
  ///Constructor for the Properties class.
  PropertiesLegacy({
    ShirtType? shirt,
    String? materialValue,
    int? fabricNumValue,
    Fit? fitValue,
    Layers? layersValue,
    WorkIntensity? workIntensityValue,
    Purpose? purposeValue,
    Scenario? scenarioValue,
    int? temperature,
    int? humidity
  }) {
    shirtType = shirt;// This uses the setter from Properties
    material = materialValue;// This uses the setter from Properties
    fabricNum = fabricNumValue;
    fit = fitValue;
    layers = layersValue;
    workIntensity = workIntensityValue;
    purpose = purposeValue;
    scenario = scenarioValue;
    this.temperature = temperature??24;
    this.humidity = humidity??57;
    min_temperature = 23;
    max_temperature = 25;
    min_humidity = 50;
    max_humidity = 65;
  }

  @override
  Map<String, String?> toJson() {
    return {
      'fabricNum': fabricNum?.toString(),
      'fit': fit?.name,
      'layers': layers?.name == 'one' ? '1' : '2',
      'workIntensity': workIntensity?.name,
      'purpose': purpose?.name,
      'scenario': scenario?.name,
      'temperature': temperature.toString(),
      'humidity': humidity.toString()
    };
  }

  @override
  List<Fit> get fitValues => Fit.values;
  @override
  List<Layers> get layersValues => Layers.values;
  @override
  List<WorkIntensity> get workIntensityValues => WorkIntensity.values;
  @override
  List<Scenario> get scenarioValues => Scenario.values;
  @override
  List<Purpose> get purposeValues => Purpose.values;

  @override
  PropertiesLegacy get properties => this;


  @override
  String toString() {
    return 'Properties: shirt: $shirtType, '
        'material: $material, fabric number: $fabricNum, '
        'fit: $fit, layers: $layers\n'
        'work intensity: $workIntensity, purpose: $purpose, '
        'scenario: $scenario, temperature: $temperature, '
        'humidity: $humidity\n';
  }

}
