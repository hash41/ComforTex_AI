import 'package:comfortex_ai/layout/screens/desktop_screen_1.dart';
import 'package:comfortex_ai/layout/screens/mobile_screen_1.dart';
import 'package:flutter/material.dart';

///a [main] function to start and stop the app.
void main() {
  runApp(const App());
}

///A stateless widget to call and display the screens based on screenWidth.
///It will show me an empty box now if the screen < 600 because the mobile
///version of the app is not implemented.
class App extends StatelessWidget {
  ///Default constructor for the App Widget.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //TODO: to build based on screenSize:  <1200 to tablet >1200 to desktop
    return MaterialApp(
      title: 'ComforTex AI',
      initialRoute: '/',
      routes: {
        '/': (context) => screenWidth < 600 ? const MobileScreen1() : const DesktopScreen1(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.dark,
        sliderTheme: SliderTheme.of(context).copyWith(
          activeTrackColor: Colors.grey[300],
          inactiveTrackColor: Colors.grey[300],
          trackShape: const RectangularSliderTrackShape(),
          trackHeight: 4,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
          thumbColor: Colors.black,
          overlayColor: Colors.grey[200],
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 26),
          valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
          valueIndicatorColor: Colors.grey[200],
          valueIndicatorTextStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
