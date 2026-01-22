import 'package:flutter/services.dart';


///A function to list the assets in a folderPath.
Future<List<String>> listAssets(String folderPath) async {
  // Normalize so startsWith works reliably
  if (!folderPath.endsWith('/')) folderPath = '$folderPath/';

  final manifest = await AssetManifest.loadFromAssetBundle(rootBundle); //  [oai_citation:1‡api.flutter.dev](https://api.flutter.dev/flutter/services/AssetManifest/loadFromAssetBundle.html?utm_source=chatgpt.com)
  final assets = manifest
      .listAssets() // List<String> of main asset keys  [oai_citation:2‡api.flutter.dev](https://api.flutter.dev/flutter/services/AssetManifest/listAssets.html?utm_source=chatgpt.com)
      .where((key) => key.startsWith(folderPath))
      .map((key) => key.substring(folderPath.length))
      .toList();

  return assets;
}
