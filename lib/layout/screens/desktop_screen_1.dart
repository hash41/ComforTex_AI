import 'package:comfortex_ai/layout/screens/waiting_screen.dart';
import 'package:comfortex_ai/layout/ui_components/common/my_custom_scroll_behavior.dart';
import 'package:comfortex_ai/layout/ui_components/common/top_bar.dart';
import 'package:comfortex_ai/layout/ui_components/desktop/bottom_widget.dart';
import 'package:comfortex_ai/layout/ui_components/desktop/center_widget.dart';
import 'package:comfortex_ai/model/Properties_v2.dart';
import 'package:comfortex_ai/utils/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///DesktopScreen1 that gives us a display of the desktop widgets for screen 1.
class DesktopScreen1 extends StatefulWidget {
  ///DesktopScreen1 constructor.
  const DesktopScreen1(this.properties, {super.key});

  ///Properties selected previously passed to the current widget
  final PropertiesV2 properties;

  @override
  State<DesktopScreen1> createState() => _DesktopScreen1State();
}

/// the good state of the stateful widget of yours.
class _DesktopScreen1State extends State<DesktopScreen1>
    with TickerProviderStateMixin {
  ScrollController scroller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  ///Method change the shirt type. and change the state of the widget.
  void changeShirt(ShirtType shirtType) {
    setState(() {
      widget.properties.shirtType = shirtType;
    });
  }

  ///Method setDescription takes a description. set the state of the widget.
  void setDescription(String description) {
    setState(() {
      widget.properties.material = description;
    });
  }

  //Build method of the widget.
  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.sizeOf(context).height;
    if (pageHeight < 500) {
      return Listener(
        onPointerSignal: (pointerSignal) {
          // Check if the event is a scroll event.
          if (pointerSignal is PointerScrollEvent) {
            // Get the vertical scroll amount from the mouse wheel.
            final scrollAmount = pointerSignal.scrollDelta.dy;
            // Manually move the horizontal scroll view by that amount.
            scroller.jumpTo(
              scroller.offset + scrollAmount / 7,
            );
          }
        },
        child: ScrollConfiguration(
          behavior: MyCustomScrollBehavior(),
          child: Scaffold(
            appBar: TopBar(
              loggedIn: true,
              options: true,
              height: Style.topBarHeightDesktop,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                controller: scroller,
                child: MouseRegion(
                  cursor: SystemMouseCursors.grab,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _createContainerDecoration(
                        padding: pageHeight * 0.01,
                        height: pageHeight * 0.55,
                        child: CenterWidget(
                          widget.properties,
                          changeShirt,
                          setDescription,
                        ),
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 750),
                        opacity: widget.properties.shirtType == null ||
                                widget.properties.material == null
                            ? 0
                            : 1,
                        child: _createContainerDecoration(
                          padding: pageHeight * 0.01,
                          height: pageHeight * 0.55,
                          child: BottomWidget(widget.properties),
                          // To-do: if card not applicable: replace with Row()
                        ),
                      ),
                      SizedBox(
                        height: pageHeight * 0.075,
                        child: AnimatedOpacity(
                          opacity: widget.properties.shirtType == null ||
                                  widget.properties.material == null
                              ? 0
                              : 1,
                          duration: const Duration(seconds: 1),
                          child: MaterialButton(
                            hoverColor: Colors.black,
                            minWidth: MediaQuery.sizeOf(context).width,
                            color: Colors.blueAccent,
                            onPressed: () async {
                              if (widget.properties.checkProperties()) {
                                await Navigator.push(
                                  context,
                                  PageRouteBuilder<WaitingScreen>(
                                    transitionDuration: const Duration(
                                      seconds: 2,
                                    ),
                                    reverseTransitionDuration: const Duration(
                                      seconds: 2,
                                    ),
                                    pageBuilder: (_, __, ___) =>
                                        WaitingScreen(widget.properties),
                                    transitionsBuilder: (context, animation1,
                                        animation2, child,) {
                                      final curved = CurvedAnimation(
                                          parent: animation1,
                                          curve: Curves.easeInOut,);
                                      return ScaleTransition(
                                        scale: curved,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Please select all properties',
                                      style: GoogleFonts.roboto(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Generate Prediction',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    fontSize: 24, color: Colors.white,),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: TopBar(
            height: Style.topBarHeightDesktop,
            loggedIn: true,
            options: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _createContainerDecoration(
                padding: pageHeight * 0.01,
                height: pageHeight * 0.37,
                child: CenterWidget(
                  widget.properties,
                  changeShirt,
                  setDescription,
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 750),
                opacity: widget.properties.shirtType == null ||
                        widget.properties.material == null
                    ? 0
                    : 1,
                child: _createContainerDecoration(
                  padding: pageHeight * 0.01,
                  height: pageHeight * 0.36,
                  child: BottomWidget(widget.properties),
                  //To-do: if card not applicable: replace with Row()
                ),
              ),
              SizedBox(
                height: pageHeight * 0.046,
                child: AnimatedOpacity(
                  opacity: widget.properties.shirtType == null ||
                          widget.properties.material == null
                      ? 0
                      : 1,
                  duration: const Duration(seconds: 1),
                  child: MaterialButton(
                    elevation: 24,
                    hoverElevation: 48,
                    hoverColor: Colors.black,
                    minWidth: MediaQuery.sizeOf(context).width,
                    color: Colors.blueAccent,
                    onPressed: () async {
                      if (widget.properties.checkProperties()) {
                        await Navigator.push(
                          context,
                          PageRouteBuilder<WaitingScreen>(
                              transitionDuration: const Duration(
                                seconds: 2,
                              ),
                              reverseTransitionDuration: const Duration(
                                seconds: 2,
                              ),
                              pageBuilder: (_, __, ___) =>
                                  WaitingScreen(widget.properties),
                              transitionsBuilder:
                                  (context, animation1, animation2, child) {
                                final curved = CurvedAnimation(
                                    parent: animation1,
                                    curve: Curves.easeInOutCubicEmphasized,);
                                return ScaleTransition(
                                  scale: curved,
                                  child: child,
                                );
                              },),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please select all properties',
                              style: GoogleFonts.roboto(),
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Generate Prediction',
                      style: GoogleFonts.roboto(
                        textStyle:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

Widget _createContainerDecoration({
  required Widget child,
  required double height,
  required double padding,
}) {
  return Container(
    padding: EdgeInsets.all(padding),
    margin: EdgeInsets.all(padding),
    height: height,
    decoration: BoxDecoration(
      border: Border.all(width: 2, color: Colors.grey),
      color: Colors.white,
      borderRadius: const BorderRadius.all(
        Radius.circular(24),
      ),
    ),
    child: child,
  );
}
