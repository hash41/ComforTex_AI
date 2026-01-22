import 'dart:convert';

import 'package:flutter/services.dart';

/// Function to parse JSON file and return a Map<String, dynamic> of key-value pairs.
Future<Map<String, dynamic>> parseJson() async {
  final jsonString = await rootBundle.loadString('assets/materials.json');
  final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
  return jsonMap;
}
