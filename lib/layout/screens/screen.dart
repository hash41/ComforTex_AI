import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:universal_html/html.dart' as html;

class Screen extends StatelessWidget {
  Screen({required Widget desktop, required Widget mobile, super.key}):
        desktopScreen = desktop,
        mobileScreen = mobile;

  Widget desktopScreen;
  Widget mobileScreen;



  static bool isMobileWeb() {
    return html.window.navigator.userAgent.contains('Mobile') ||
        html.window.navigator.userAgent.contains('Android') ||
        html.window.navigator.userAgent.contains('iPhone');
  }

  ///A function to check if the screen is mobile or not.
  static bool isMobile() {
    try {
      return Platform.isAndroid || Platform.isIOS;
    } catch (e) {
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if(screenHeight < 325 || screenWidth < 325) {
      return Container();
    }
    return isMobileWeb()
        ? mobileScreen : isMobile()
            ? mobileScreen
            : screenWidth <= 650
                ? mobileScreen
                : desktopScreen;
  }

}
