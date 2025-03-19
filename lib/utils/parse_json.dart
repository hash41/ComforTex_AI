import 'dart:convert';

import 'package:flutter/services.dart';

Future<Map<String, dynamic>> parseJson() async {
  final jsonString = await rootBundle.loadString('assets/materials.json');
  final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
  print(jsonMap);
  return jsonMap;
}
