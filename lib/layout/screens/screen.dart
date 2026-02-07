import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:universal_html/html.dart' as html;

/// A Screen class responsible for calculating the dimensions and using some
/// libs to decide whether to render a desktop widget or mobile widget.
final class Screen {
  /// Verifies if we have a mobile web browser
  static bool _isMobileWeb() {
    return html.window.navigator.userAgent.contains('Mobile') ||
        html.window.navigator.userAgent.contains('Android') ||
        html.window.navigator.userAgent.contains('iPhone');
  }

  ///A function to check if the screen is mobile: (IOS or Android) or not.
  static bool _isMobile() {
    try {
      return Platform.isAndroid || Platform.isIOS;
    } on Exception {
      return false;
    }
  }

  /// A class mold method [build] which decides which widget to render: Desktop
  /// OR mobile one.
  static Widget build(
    BuildContext context, {
    required Widget desktopScreen,
    required Widget mobileScreen,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < 325 || screenWidth < 325) {
      return Container();
    }
    return _isMobileWeb()
        ? mobileScreen
        : _isMobile()
            ? mobileScreen
            : screenWidth <= 650
                ? mobileScreen
                : desktopScreen;
  }
}
