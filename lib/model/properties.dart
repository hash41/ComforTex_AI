// import 'package:comfortex_ai/model/prediction.dart';
//
// enum ShirtType { polo, t_shirt }
//
// abstract class Properties<
//     ST extends ShirtType,
//     Fit extends Enum,
//     Layers extends Enum,
//     WorkIntensity extends Enum,
//     Purpose extends Enum,
//     Scenario extends Enum> {
//   ST? _shirtType;
//   String? _material;
//   int? _fabricNum;
//   Fit? _fit;
//   Layers? _layers;
//   WorkIntensity? _workIntensity;
//   Purpose? _purpose;
//   Scenario? _scenario;
//   int? _temperature;
//   int? _humidity;
//   Prediction? _prediction;
//   int min_temperature = 0;
//   int max_temperature = 100;
//   int min_humidity = 30;
//   int max_humidity = 90;
//
//   bool checkProperties() {
//     if (_shirtType == null ||
//         _material == null ||
//         _fabricNum == null ||
//         _fit == null ||
//         _layers == null ||
//         _workIntensity == null ||
//         _purpose == null ||
//         _scenario == null) {
//       return false;
//     }
//     return true;
//   }
//
//   Map<String, String?> toJson();
//   List<dynamic> getProperties() {
//     return [
//       _shirtType?.name,
//       _material,
//       _fabricNum,
//       _fit?.name,
//       _layers?.name,
//       _workIntensity?.name,
//       _purpose?.name,
//       _scenario?.name,
//       _temperature,
//       _humidity
//     ];
//   }
//
//   //TODO(Hash): validate and check for wrong values when possible..
//   //We will allow null because its a nullable ..
//
//   set material(String? material) {
//     _material = material;
//   }
//
//   String? get material {
//     return _material;
//   }
//
//   set fabricNum(int? fabricNum) {
//     _fabricNum = fabricNum;
//   }
//
//   int? get fabricNum {
//     return _fabricNum;
//   }
//
//   ST? get shirtType {
//     return _shirtType;
//   }
//
//   Fit? get fit {
//     return _fit;
//   }
//
//   Layers? get layers {
//     return _layers;
//   }
//
//   WorkIntensity? get workIntensity {
//     return _workIntensity;
//   }
//
//   Purpose? get purpose => _purpose;
//   Scenario? get scenario => _scenario;
//   int? get temperature {
//     return _temperature;
//   }
//
//   int? get humidity {
//     return _humidity;
//   }
//
//   Properties get properties {
//     return this;
//   }
//
//   Prediction? get prediction {
//     return _prediction;
//   }
//
//   set shirtType(ST? shirtType) {
//     _shirtType = shirtType;
//   }
//
//   set fit(Fit? fit) {
//     _fit = fit;
//   }
//
//   set layers(Layers? layers) {
//     _layers = layers;
//   }
//
//   set workIntensity(WorkIntensity? workIntensity) {
//     _workIntensity = workIntensity;
//   }
//
//   set purpose(Purpose? purpose) {
//     _purpose = purpose;
//   }
//
//   set scenario(Scenario? scenario) {
//     _scenario = scenario;
//   }
//
//   set temperature(int? temperature) {
//     if (temperature != null && temperature < min_temperature) {
//       _temperature = min_temperature;
//     } else if (temperature != null && temperature > max_temperature) {
//       _temperature = max_temperature;
//     } else {
//       _temperature = temperature;
//     }
//   }
//
//   set humidity(int? humidity) {
//     if (humidity != null && humidity > max_humidity) {
//       _humidity = max_humidity;
//     } else if (humidity != null && humidity < min_humidity) {
//       _humidity = min_humidity;
//     } else {
//       _humidity = humidity;
//     }
//   }
//
//   set prediction(Prediction? prediction) {
//     _prediction = prediction;
//   }
//
//   List<ShirtType> get shirtTypeValues {
//     return ShirtType.values;
//   }
//
//   List<Fit> get fitValues;
//   List<Layers> get layersValues;
//   List<WorkIntensity> get workIntensityValues;
//   List<Scenario> get scenarioValues;
//   List<Purpose> get purposeValues;
// }
