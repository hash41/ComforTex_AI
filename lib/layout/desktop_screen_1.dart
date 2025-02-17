import 'package:flutter/material.dart';

import 'app_widgets/top_bar.dart';
import 'app_widgets/center_widget.dart';

class DesktopScreen1 extends StatefulWidget {
  const DesktopScreen1({super.key});

  @override
  State<DesktopScreen1> createState() => _DesktopScreen1State();
}

class _DesktopScreen1State extends State<DesktopScreen1> {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height * 0.03);
    return Scaffold(
        appBar: TopBar(MediaQuery.of(context).size.height * 0.124),
        body: Column(
          children: [
            _createContainerDecoration(
                padding: MediaQuery.of(context).size.height * 0.03,
                height: MediaQuery.of(context).size.height * 0.4,
                child: CenterWidget()),
            _createContainerDecoration(
              padding: MediaQuery.of(context).size.height * 0.03,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Container(),
              //TODO: if card not applicable: replace with Row()
            ),
          ],
        ));
  }
}

Widget _createContainerDecoration(
    {required Widget child, required double height, required double padding}) {
  return Container(
    padding: EdgeInsets.all(padding),
    margin: EdgeInsets.all(padding),
    height: height,
    decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Colors.grey),
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        )),
    child: child,
  );
}
