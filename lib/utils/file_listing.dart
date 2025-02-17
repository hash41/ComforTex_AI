import 'dart:convert';              // for jsonDecode
import 'package:flutter/services.dart' show rootBundle;

  Future<List<String>> listAssets(String folderPath) async {
    // Load the AssetManifest.json file as a string
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    // Decode the JSON into a Map
    final Map<String, dynamic> manifestMap = jsonDecode(manifestContent);

    // The keys of this map are full asset paths like "assets/images/image1.png"
    // We filter them by checking if they start with our desired folder path
    final assets = manifestMap.keys
        .where((String key) => key.startsWith(folderPath))
        .map((str) => str.replaceAll(folderPath, ''))
        .toList();
    print(assets);
    return assets;
  }


