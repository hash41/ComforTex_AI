import 'package:comfortex_ai/layout/components/bottom_widget.dart';
import 'package:flutter/material.dart';
import 'components/top_bar.dart';
import 'components/center_widget.dart';


///DesktopScreen1 that gives us a display of the desktop widgets for screen 1.
class DesktopScreen1 extends StatefulWidget {
  const DesktopScreen1({super.key});

  @override
  State<DesktopScreen1> createState() => _DesktopScreen1State();
}

/// the good state of the stateful widget of yours.
class _DesktopScreen1State extends State<DesktopScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(MediaQuery.of(context).size.height * 0.124),
        body: Column(
          children: [
            _createContainerDecoration(
                padding: MediaQuery.of(context).size.height * 0.03,
                height: MediaQuery.of(context).size.height * 0.4,
                child: const CenterWidget()),
            _createContainerDecoration(
              padding: MediaQuery.of(context).size.height * 0.03,
              height: MediaQuery.of(context).size.height * 0.35,
              child: const BottomWidget(),
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
