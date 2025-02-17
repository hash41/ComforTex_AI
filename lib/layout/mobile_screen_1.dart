import 'package:flutter/material.dart';


///MobileScreen1 displays the Mobile version screen1.
class MobileScreen1 extends StatefulWidget {
  const MobileScreen1({super.key});

  @override
  State<MobileScreen1> createState() => _MobileScreen1State();
}


class _MobileScreen1State extends State<MobileScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (BuildContext context,Orientation orientation) {
        if(orientation == Orientation.portrait) {
          return Container();
        }
        else {
          return Container();
        }
      })
    );
  }
}
