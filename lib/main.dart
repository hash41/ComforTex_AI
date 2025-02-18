import 'package:flutter/material.dart';
import 'package:comfortex_ai/layout/desktop_screen_1.dart';
import 'package:comfortex_ai/layout/mobile_screen_1.dart';


///a [main] function to start and stop the app.
void main() {
  runApp(const App());
}

///A stateless widget to call and display the screens based on screenWidth.
///It will show me an empty box now if the screen < 600 because the mobile
///version of the app is not implemented.
class App extends StatelessWidget {

  const App({super.key});


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //TODO: to build based on screenSize:  <1200 tablet >1200 desktop
    return MaterialApp(
      title: 'ComforTex AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: screenWidth < 600 ? const MobileScreen1(): const DesktopScreen1()
    );
  }
}