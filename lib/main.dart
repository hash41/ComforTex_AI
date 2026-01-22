import 'dart:io' show HttpOverrides, Platform;

import 'package:comfortex_ai/exception/bad_request_exception.dart';
import 'package:comfortex_ai/exception/endpoint_not_found_exception.dart';
import 'package:comfortex_ai/exception/many_requests_exception.dart';
import 'package:comfortex_ai/exception/server_exception.dart';
import 'package:comfortex_ai/layout/screens/desktop_login_screen.dart';
import 'package:comfortex_ai/layout/screens/desktop_screen_1.dart';
import 'package:comfortex_ai/layout/screens/desktop_welcome_screen.dart';
import 'package:comfortex_ai/layout/screens/mobile_screen_1.dart';
import 'package:comfortex_ai/layout/screens/mobile_welcome_screen.dart';
import 'package:comfortex_ai/layout/screens/screen.dart';
import 'package:comfortex_ai/layout/screens/select_ai_screen.dart';
import 'package:comfortex_ai/model/Properties_v2.dart';
import 'package:comfortex_ai/model/properties.dart';
import 'package:comfortex_ai/utils/auth_api_mobile.dart';
import 'package:comfortex_ai/utils/auth_api_web.dart';
import 'package:comfortex_ai/utils/my_http_overrides.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

///a [main] function to start and stop the app.
///TODO: need to update the app for 4k resolution...
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global =
      MyHttpOverrides(); //Temporary override, TODO: NOT FOR PRODUCTION
  bool loggedIn = false;
  try {
    ///TODO: the refreshToken on web will not work in development
    ///TODO: because we are on local host but the backend is on "mac.lan"
    PropertiesV2 propertiesV2 = PropertiesV2();
    final props = await propertiesV2.generateProperties();
    print(propertiesV2);
    if(kIsWeb) {
    loggedIn = await AuthApiWeb().isLoggedIn();
    } else {
      loggedIn = await AuthApiMobile().isLoggedIn();
    }
  } on ManyRequestsException catch (e) {
    if (kDebugMode) {
      print(
        'We log user out here because he reached allowed connections limit',);
    }
    loggedIn = false;
  } on ServerException catch (e) {
    //..
    if (kDebugMode) {
      print(e);
    }
  } on EndpointNotFoundException catch (e) {
    if (kDebugMode) {
      print(e.message);
    }
  } on ClientException catch (e) {
    if (kDebugMode) {
      print('client exception');
    }
    //
  } on BadRequestException catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  catch (e) {
    if (kDebugMode) {
      print('An exception of a new sort in main:');
      print(e);
    }
  }
  runApp(App(loggedIn));
}

///A stateless widget to call and display the screens based on screenWidth.
///It will show me an empty box now if the screen < 600 because the mobile
///version of the app is not implemented.
class App extends StatelessWidget {
  ///Default constructor for the App Widget.
  App(bool loggedIn, {super.key}) : _loggedIn = loggedIn;
  late bool _loggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ComforTex AI',
      home: _loggedIn
          ? SelectAiScreen()
          : Screen(
              desktop: const DesktopWelcomeScreen(),
              mobile: const MobileWelcomeScreen(),
              // desktop: DesktopScreen1(properties),
              // mobile: MobileScreen1(properties),
            ),
      theme: ThemeData.light().copyWith(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: 1.5, color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: 1.5, color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: 3, color: Colors.pink),
          ),
          fillColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.dark,
        sliderTheme: SliderTheme.of(context).copyWith(
          activeTrackColor: Colors.grey[300],
          inactiveTrackColor: Colors.grey[300],
          trackShape: const RectangularSliderTrackShape(),
          trackHeight: 4,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
          thumbColor: Colors.black,
          overlayColor: Colors.lightGreen,
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 26),
          valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
          valueIndicatorColor: Colors.grey[200],
          valueIndicatorTextStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
        textTheme: TextTheme(
            displayLarge: TextStyle(
          fontFamily: 'Arial',
        ),),
      ),
    );
  }
}
