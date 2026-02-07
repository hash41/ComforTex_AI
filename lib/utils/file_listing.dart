import 'package:flutter/services.dart';


///A function to list the assets in a folderPath.
Future<List<String>> listAssets(String folderPath) async {
  // Normalize so startsWith works reliably
  var path = folderPath;
  if (!folderPath.endsWith('/')) {
    path = '$folderPath/';
  }

  final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  final assets = manifest
      .listAssets()
      .where((key) => key.startsWith(path))
      .map((key) => key.substring(path.length))
      .toList();

  return assets;
}
