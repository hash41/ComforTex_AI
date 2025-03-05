import 'package:comfortex_ai/layout/components/bottom_widget.dart';
import 'package:comfortex_ai/layout/components/center_widget.dart';
import 'package:comfortex_ai/layout/components/top_bar.dart';
import 'package:flutter/material.dart';

///DesktopScreen1 that gives us a display of the desktop widgets for screen 1.
class DesktopScreen1 extends StatefulWidget {
  ///DesktopScreen1 constructor.
  const DesktopScreen1({super.key});

  @override
  State<DesktopScreen1> createState() => _DesktopScreen1State();
}

/// the good state of the stateful widget of yours.
class _DesktopScreen1State extends State<DesktopScreen1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TopBar(MediaQuery.of(context).size.height * 0.1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _createContainerDecoration(
                padding: MediaQuery.of(context).size.height * 0.02,
                height: MediaQuery.of(context).size.height * 0.38,
                child: const CenterWidget()),
            _createContainerDecoration(
              padding: MediaQuery.of(context).size.height * 0.02,
              height: MediaQuery.of(context).size.height * 0.35,
              child: const BottomWidget(),
              //TODO: if card not applicable: replace with Row()
            ),
            SizedBox(
              //0.934
              height: MediaQuery.of(context).size.height * 0.05,
              child: MaterialButton(
                elevation: 24,
                hoverElevation: 48,
                hoverColor: Colors.black,
                minWidth: MediaQuery.of(context).size.width * 0.98,
                color: Colors.blueAccent,
                onPressed: () {},
                child: const Text(
                  'Generate Prediction',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _createContainerDecoration(
    {required Widget child, required double height, required double padding,}) {
  return Container(
    padding: EdgeInsets.all(padding),
    margin: EdgeInsets.all(padding),
    height: height,
    decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey),
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),),
    child: child,
  );
}
