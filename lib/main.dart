import 'dart:io' show HttpOverrides;

import 'package:comfortex_ai/exception/bad_request_exception.dart';
import 'package:comfortex_ai/exception/endpoint_not_found_exception.dart';
import 'package:comfortex_ai/exception/many_requests_exception.dart';
import 'package:comfortex_ai/exception/server_exception.dart';
import 'package:comfortex_ai/layout/screens/desktop_welcome_screen.dart';
import 'package:comfortex_ai/layout/screens/mobile_welcome_screen.dart';
import 'package:comfortex_ai/layout/screens/screen.dart';
import 'package:comfortex_ai/layout/screens/select_ai_screen.dart';
import 'package:comfortex_ai/utils/auth_api_mobile.dart';
import 'package:comfortex_ai/utils/auth_api_web.dart';
import 'package:comfortex_ai/utils/my_http_overrides.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

///a [main] function to start and stop the app.
//TODO(Hash): need to test and update the app for 4k resolution...
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global =
      MyHttpOverrides(); //Temporary override, TODO(Hash): NOT FOR PRODUCTION
  var loggedIn = false;
  try {
    //TODO(Hash): the refreshToken on web will not work in development
    //TODO(Hash): because we are on local host but the backend is on "mac.lan"
    if (kIsWeb) {
      loggedIn = await AuthApiWeb().isLoggedIn();
    } else {
      loggedIn = await AuthApiMobile().isLoggedIn();
    }
  } on ManyRequestsException {
    if (kDebugMode) {
      print(
        'We log user out here because he reached allowed connections limit',
      );
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
  } on ClientException {
    if (kDebugMode) {
      print('client exception');
    }
    //
  } on BadRequestException catch (e) {
    if (kDebugMode) {
      print(e);
    }
  } on Exception catch (e) {
    if (kDebugMode) {
      print('An exception of a new sort in main:');
      print(e);
    }
  }
  runApp(App(loggedIn: loggedIn));
}

///A stateless widget to call and display the screens based on screenWidth.
///It will show me an empty box now if the screen < 600 because the mobile
///version of the app is not implemented.
class App extends StatelessWidget {
  ///Default constructor for the App Widget.
  const App({bool loggedIn = false, super.key}) : _loggedIn = loggedIn;
  final bool _loggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ComforTex AI',
      home: _loggedIn
          ? SelectAiScreen()
          : Screen.build(
              context,
              desktopScreen: const DesktopWelcomeScreen(),
              mobileScreen: const MobileWelcomeScreen(),
            ),
      theme: ThemeData.light().copyWith(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: 1.5),
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
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'Arial',
          ),
        ),
      ),
    );
  }
}
