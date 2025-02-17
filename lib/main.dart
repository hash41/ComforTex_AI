import 'package:flutter/material.dart';
import 'package:comfortex_ai/layout/desktop_screen_1.dart';
import 'package:comfortex_ai/layout/mobile_screen_1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //TODO: to build based on screensize:  <1200 tablet >1200 desktop
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