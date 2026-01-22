import 'package:comfortex_ai/layout/screens/waiting_screen.dart';
import 'package:comfortex_ai/layout/ui_components/common/title_widget.dart';
import 'package:comfortex_ai/layout/ui_components/common/top_bar.dart';
import 'package:comfortex_ai/layout/ui_components/mobile/back_button.dart';
import 'package:comfortex_ai/model/ai_version.dart';
import 'package:comfortex_ai/model/properties.dart';
import 'package:comfortex_ai/utils/assets.dart';
import 'package:comfortex_ai/utils/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class GarmentPropertiesScreen extends StatefulWidget {
  final Properties properties;
  const GarmentPropertiesScreen({required this.properties, super.key});

  @override
  State<GarmentPropertiesScreen> createState() =>
      _GarmentPropertiesScreenState();
}

class _GarmentPropertiesScreenState extends State<GarmentPropertiesScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fillAnimation;
  late AnimationController _controller2;
  late Animation<double> _fillAnimation2;
  late AnimationController _controller3;
  late Animation<double> _fillAnimation3;
  late AnimationController _controller4;
  late Animation<double> _fillAnimation4;
  List<String> greyedOut = [
    'Two',
    'two',
    'Three',
    'low',
    'high',
    'Light',
    'High',
    'outdoors',
    'Outdoors'
  ];

  @override
  void initState() {
    super.initState();
    if(kDebugMode)
      {
    print(AiVersionStore.instance.aiVersion);
      }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fillAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {});
      });
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fillAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller2, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {});
      });
    _controller3 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fillAnimation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller3, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {});
      });
    _controller4 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fillAnimation4 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller4, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {});
      });
    _checkForAnimationTrigger();
    _checkForAnimationTrigger2();
    _checkForAnimationTrigger3();
    _checkForAnimationTrigger4();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  void _checkForAnimationTrigger() {
    if (widget.properties.fit != null && widget.properties.layers != null) {
      _controller.forward();
    }
  }

  void _checkForAnimationTrigger2() {
    if (widget.properties.workIntensity != null &&
        widget.properties.purpose != null &&
        widget.properties.scenario != null) {
      _controller2.forward();
    }
  }

  void _checkForAnimationTrigger3() {
    if (widget.properties.temperature != 20) {
      _controller3.forward();
    }
  }

  void _checkForAnimationTrigger4() {
    if (widget.properties.humidity != 50) {
      _controller4.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.portrait) {
          return Scaffold(
            appBar: TopBar(
              leading: const MaterialBackButton(),
              loggedIn: true,
              options: true,
              height: Style.topBarHeightPortrait,
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const TitleWidget(
                            iconPath: Assets.T_SHIRT_ICON,
                            title: 'Garment Properties',
                            isMobile: true,
                          ),
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Stack(
                              children: [
                                buildPositionedPurple(1),
                                buildPositionedGreen(_fillAnimation.value),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const Gap(2),
                                    ..._buildButtons(
                                        'Fit',
                                        widget.properties.fitValues,
                                        widget.properties.fit, (newValue) {
                                      setState(() {
                                        widget.properties.fit = newValue;
                                      });
                                      _checkForAnimationTrigger();
                                    }),
                                    const Gap(2),
                                    ..._buildButtons(
                                        'Layers',
                                        widget.properties.layersValues,
                                        widget.properties.layers,
                                        (Enum newValue) {
                                      setState(() {
                                        widget.properties.layers = newValue;
                                      });
                                      _checkForAnimationTrigger();
                                    }),
                                    const Gap(
                                      5,
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: widget.properties.fit != null &&
                                          widget.properties.layers != null
                                      ? const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 32,
                                        )
                                      : Container(),
                                ),
                              ],
                            ),
                          ),
                          const TitleWidget(
                              iconPath: Assets.ACTIVITY_SETTINGS_ICON,
                              title: 'Activity Settings',
                              isMobile: true),
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Stack(
                              children: [
                                buildPositionedPurple(1),
                                buildPositionedGreen(_fillAnimation2.value),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const Gap(2),
                                    ..._buildButtons(
                                        'Work Intensity',
                                        widget.properties.workIntensityValues,
                                        widget.properties.workIntensity,
                                        (Enum newValue) {
                                      setState(() {
                                        widget.properties.workIntensity =
                                            newValue;
                                      });
                                      _checkForAnimationTrigger2();
                                    }),
                                    const Gap(2),
                                    ..._buildButtons(
                                        'Purpose',
                                        widget.properties.purposeValues,
                                        widget.properties.purpose,
                                        (Enum newValue) {
                                      setState(() {
                                        widget.properties.purpose = newValue;
                                      });
                                      _checkForAnimationTrigger2();
                                    }),
                                    const Gap(2),
                                    ..._buildButtons(
                                        'Scenario',
                                        widget.properties.scenarioValues,
                                        widget.properties.scenario,
                                        (Enum newValue) {
                                      setState(() {
                                        widget.properties.scenario = newValue;
                                      });
                                      _checkForAnimationTrigger2();
                                    }),
                                    const Gap(
                                      5,
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: widget.properties.scenario != null &&
                                          widget.properties.purpose != null &&
                                          widget.properties.workIntensity !=
                                              null
                                      ? const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 32,
                                        )
                                      : Container(),
                                ),
                              ],
                            ),
                          ),
                          const TitleWidget(
                              iconPath: Assets.ENVIRONMENTAL_VAR_ICON,
                              title: 'Environmental Variables',
                              isMobile: true),
                          Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: buildIconsColumn('Temperature',
                                        widget.properties.temperature!, () {
                                      setState(() {
                                        widget.properties.temperature =
                                            widget.properties.temperature! + 1;
                                      });
                                      _checkForAnimationTrigger3();
                                    }, () {
                                      setState(() {
                                        widget.properties.temperature =
                                            widget.properties.temperature! - 1;
                                      });
                                      _checkForAnimationTrigger3();
                                    }),
                                  ),
                                  Flexible(
                                    child: buildIconsColumn(
                                        'Humidity', widget.properties.humidity!,
                                        () {
                                      setState(() {
                                        widget.properties.humidity =
                                            widget.properties.humidity! + 1;
                                      });
                                      _checkForAnimationTrigger4();
                                    }, () {
                                      setState(() {
                                        widget.properties.humidity =
                                            widget.properties.humidity! - 1;
                                      });
                                      _checkForAnimationTrigger4();
                                    }),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: widget.properties.temperature != 20 &&
                                        widget.properties.humidity != 50
                                    ? const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 32,
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (widget.properties.checkProperties()) {
                                await Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      transitionDuration: const Duration(
                                        seconds: 2,
                                      ),
                                      reverseTransitionDuration: const Duration(
                                        seconds: 2,
                                      ),
                                      pageBuilder: (_, __, ___) =>
                                          WaitingScreen(widget.properties),
                                      transitionsBuilder: (context, animation1,
                                          animation2, child) {
                                        final curved = CurvedAnimation(
                                            parent: animation1,
                                            curve: Curves
                                                .easeInOutCubicEmphasized);
                                        return ScaleTransition(
                                          scale: curved,
                                          child: child,
                                        );
                                      }),
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
                            style: const ButtonStyle(
                              padding: WidgetStatePropertyAll(EdgeInsets.zero),
                              elevation: WidgetStatePropertyAll(2),
                              foregroundColor:
                                  WidgetStatePropertyAll(Colors.white),
                              backgroundColor: WidgetStatePropertyAll(
                                  Colors.lightBlueAccent),
                              overlayColor:
                                  WidgetStatePropertyAll(Colors.black),
                              shadowColor: WidgetStatePropertyAll(Colors.pink),
                              fixedSize: WidgetStatePropertyAll(Size(200, 32)),
                              minimumSize:
                                  WidgetStatePropertyAll(Size(120, 34)),
                              maximumSize:
                                  WidgetStatePropertyAll(Size(240, 50)),
                              animationDuration: Duration(seconds: 2),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                              ),
                              side: WidgetStatePropertyAll(
                                BorderSide(
                                  color: Colors.lightBlue,
                                ),
                              ),
                            ),
                            child: Text(
                              'Prediction',
                              style: GoogleFonts.roboto(
                                textStyle:
                                    Style.buttonTextMobile.copyWith(height: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: TopBar(
              leading: const MaterialBackButton(),
              loggedIn: true,
              options: true,
              height: Style.topBarHeightLandscape,
            ),
            body: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TitleWidget(
                          iconPath: Assets.T_SHIRT_ICON,
                          title: 'Garment Properties',
                          isMobile: true,
                          isLandscape: true,
                        ),
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              buildPositionedPurple(1),
                              buildPositionedGreen(_fillAnimation.value),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Gap(2),
                                  ..._buildButtons(
                                    'Fit',
                                    widget.properties.fitValues,
                                    widget.properties.fit,
                                    (newValue) {
                                      setState(() {
                                        widget.properties.fit = newValue;
                                      });
                                      _checkForAnimationTrigger();
                                    },
                                  ),
                                  const Gap(2),
                                  ..._buildButtons(
                                    'Layers',
                                    widget.properties.layersValues,
                                    widget.properties.layers,
                                    (Enum newValue) {
                                      setState(() {
                                        widget.properties.layers = newValue;
                                      });
                                      _checkForAnimationTrigger();
                                    },
                                  ),
                                  const Gap(5),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Gap(5),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TitleWidget(
                          iconPath: Assets.ACTIVITY_SETTINGS_ICON,
                          title: 'Activity Settings',
                          isMobile: true,
                          isLandscape: true,
                        ),
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              buildPositionedPurple(1),
                              buildPositionedGreen(_fillAnimation2.value),
                              Column(mainAxisSize: MainAxisSize.min, children: [
                                const Gap(2),
                                ..._buildButtons(
                                  'Work Intensity',
                                  widget.properties.workIntensityValues,
                                  widget.properties.workIntensity,
                                  (newValue) {
                                    setState(() {
                                      widget.properties.workIntensity =
                                          newValue;
                                    });
                                    _checkForAnimationTrigger2();
                                  },
                                ),
                                const Gap(2),
                                ..._buildButtons(
                                  'Purpose',
                                  widget.properties.purposeValues,
                                  widget.properties.purpose,
                                  (newValue) {
                                    setState(() {
                                      widget.properties.purpose = newValue;
                                    });
                                    _checkForAnimationTrigger2();
                                  },
                                ),
                                const Gap(2),
                                ..._buildButtons(
                                  'Scenario',
                                  widget.properties.scenarioValues,
                                  widget.properties.scenario,
                                  (newValue) {
                                    setState(() {
                                      widget.properties.scenario = newValue;
                                      _checkForAnimationTrigger2();
                                    });
                                  },
                                ),
                                const Gap(5),
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(5),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TitleWidget(
                          iconPath: Assets.ENVIRONMENTAL_VAR_ICON,
                          title: 'Environmental Variables',
                          isMobile: true,
                          isLandscape: true,
                        ),
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            children: [
                              buildIconsColumn(
                                  'Temperature', widget.properties.temperature!,
                                  () {
                                setState(() {
                                  widget.properties.temperature =
                                      widget.properties.temperature! + 1;
                                });
                                _checkForAnimationTrigger3();
                              }, () {
                                setState(() {
                                  widget.properties.temperature =
                                      widget.properties.temperature! - 1;
                                });
                                _checkForAnimationTrigger3();
                              }, landscape: true),
                              buildIconsColumn(
                                  'Humidity', widget.properties.humidity!, () {
                                setState(() {
                                  widget.properties.humidity =
                                      widget.properties.humidity! + 1;
                                });
                                _checkForAnimationTrigger4();
                              }, () {
                                setState(() {
                                  widget.properties.humidity =
                                      widget.properties.humidity! - 1;
                                });
                                _checkForAnimationTrigger4();
                              }, landscape: true),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (widget.properties.checkProperties()) {
                              await Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(
                                    seconds: 2,
                                  ),
                                  reverseTransitionDuration: const Duration(
                                    seconds: 2,
                                  ),
                                  pageBuilder: (_, __, ___) =>
                                      WaitingScreen(widget.properties),
                                  transitionsBuilder: (
                                    context,
                                    animation1,
                                    animation2,
                                    child,
                                  ) {
                                    final curved = CurvedAnimation(
                                      parent: animation1,
                                      curve: Curves.easeInOutCubicEmphasized,
                                    );
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
                                  ),
                                ),
                              );
                            }
                          },
                          style: const ButtonStyle(
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.zero,
                            ),
                            elevation: WidgetStatePropertyAll(
                              1,
                            ),
                            foregroundColor: WidgetStatePropertyAll(
                              Colors.white,
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.blue,
                            ),
                            overlayColor: WidgetStatePropertyAll(
                              Colors.black,
                            ),
                            shadowColor: WidgetStatePropertyAll(
                              Colors.pink,
                            ),
                            minimumSize: WidgetStatePropertyAll(
                              Size(
                                110,
                                25,
                              ),
                            ),
                            maximumSize: WidgetStatePropertyAll(
                              Size(
                                150,
                                40,
                              ),
                            ),
                            animationDuration: Duration(seconds: 2),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16),),
                              ),
                            ),
                            side: WidgetStatePropertyAll(
                              BorderSide(
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                          child: Text(
                            'Prediction',
                            style: GoogleFonts.roboto(
                              textStyle:
                                  Style.buttonTextMobile.copyWith(height: 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Positioned buildPositionedGreen(double value) {
    return Positioned.fill(
      //A Positioned.fill makes the child and parent communicate the space correctly.
      child: FractionallySizedBox(
        alignment: Alignment.bottomCenter,
        heightFactor: value,
        widthFactor: 1,
        child: Container(
          color: Colors.green.shade100,
        ),
      ),
    );
  }

  Positioned buildPositionedPurple(double value) {
    return Positioned.fill(
      //A Positioned.fill makes the child and parent communicate the space correctly.
      child: FractionallySizedBox(
        alignment: Alignment.bottomCenter,
        heightFactor: value,
        widthFactor: 1,
        child: Container(
          color: Colors.purple.shade50,
        ),
      ),
    );
  }

  Widget buildIconsColumn(
    String title,
    int value,
    void Function() increment,
    void Function() decrement, {
    bool landscape = false,
  }) {
    if (landscape) {
      return Stack(
        children: [
          buildPositionedPurple(1),
          Positioned.fill(
            //A Positioned.fill makes the child and parent communicate the space correctly.
            child: FractionallySizedBox(
              alignment: Alignment.bottomCenter,
              heightFactor: title == 'Temperature'
                  ? _fillAnimation3.value
                  : _fillAnimation4.value,
              child: Container(
                color: Colors.green.shade100,
              ),
            ),
          ),
          Column(
            children: [
              Text(
                title,
                style: GoogleFonts.roboto(
                  textStyle: Style.mobileSubtitle.copyWith(height: 1.5),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                      foregroundColor: WidgetStatePropertyAll(Colors.black),
                      overlayColor: WidgetStatePropertyAll(Colors.orange),
                    ),
                    color: Colors.black,
                    onPressed: decrement,
                    icon: const Icon(
                      Icons.remove,
                      size: 36,
                    ),
                  ),
                  Text(
                    value.toString(),
                    style: GoogleFonts.roboto(
                      textStyle: Style.mobileSubtitle.copyWith(height: 1),
                    ),
                  ),
                  IconButton(
                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                      foregroundColor: WidgetStatePropertyAll(Colors.black),
                      overlayColor: WidgetStatePropertyAll(Colors.orange),
                    ),
                    color: Colors.black,
                    onPressed: increment,
                    icon: const Icon(
                      Icons.add,
                      size: 36,
                    ),
                  ),
                ],
              ),
              if (title == 'humidity') const Gap(5),
            ],
          ),
        ],
      );
    }
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: title == 'Temperature'
            ? const BorderRadius.horizontal(
                left: Radius.circular(16),
              )
            : const BorderRadius.horizontal(
                right: Radius.circular(16),
              ),
      ),
      child: Stack(
        children: [
          buildPositionedPurple(1),
          Positioned.fill(
            //A Positioned.fill makes the child and parent communicate the space correctly.
            child: FractionallySizedBox(
              alignment: Alignment.bottomCenter,
              heightFactor: title == 'Temperature'
                  ? _fillAnimation3.value
                  : _fillAnimation4.value,
              child: Container(
                color: Colors.green.shade100,
              ),
            ),
          ),
          Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              title,
              style: GoogleFonts.roboto(
                textStyle: Style.mobileSubtitle.copyWith(height: 1.5),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: IconButton(
                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                      foregroundColor: WidgetStatePropertyAll(Colors.black),
                      overlayColor: WidgetStatePropertyAll(Colors.orange),
                    ),
                    color: Colors.black,
                    onPressed: decrement,
                    icon: const Icon(
                      Icons.remove,
                      size: 25,
                    ),
                  ),
                ),
                Text(
                  value.toString(),
                  style: GoogleFonts.roboto(
                    textStyle: Style.mobileSubtitle,
                  ),
                ),
                Flexible(
                  child: IconButton(
                    //TODO: refactor
                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                      foregroundColor: WidgetStatePropertyAll(Colors.black),
                      overlayColor: WidgetStatePropertyAll(Colors.orange),
                    ),
                    color: Colors.black,
                    onPressed: increment,
                    icon: const Icon(
                      Icons.add,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(5),
          ]),
        ],
      ),
    );
  }

  List<Widget> _buildButtons<T extends Enum>(
    String title,
    List<T> enumValues,
    T? finalValue,
    ValueChanged<T> onChanged,
  ) {
    //we have a list of enum values and we have the finalValue that is the one that is selected.
    //OnChanged changes that value?
    //ValueChanged is a function that takes a value of type where the change happened (T).
    List<Widget> r = [
      Center(
        child: Text(
          title,
          style: GoogleFonts.roboto(
            textStyle: Style.mobileSubtitle.copyWith(height: 1.5),
          ),
          overflow: TextOverflow.clip,
          maxLines: 1,
        ),
      ),
    ];
    Wrap buttons = Wrap(
      spacing: 12,
      runSpacing: 4,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [],
    );
    for (final T value in enumValues) {
      bool greyOut = greyedOut.contains(value.name);
      buttons.children.add(
        ElevatedButton(
          onPressed: () {
            if (!greyOut) {
              onChanged(value);
            }
          },
          style: getButtonStyle(finalValue == value, greyedOut: greyOut),
          child: Text(
            value.name.toLowerCase(),
            style: GoogleFonts.roboto(
              textStyle: Style.bodyTextMobile.copyWith(height: 1),
            ),
          ),
        ),
      );
    }
    r.add(buttons);
    return r;
  }

  ButtonStyle getButtonStyle(bool selected, {bool? greyedOut}) {
    if (greyedOut != null && greyedOut) {
      return ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
        elevation: WidgetStatePropertyAll(1),
        backgroundColor: WidgetStatePropertyAll(Colors.grey.shade300),
        minimumSize: const WidgetStatePropertyAll(
          Size(75, 30),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        maximumSize: const WidgetStatePropertyAll(
          Size(200, 34),
        ),
        foregroundColor: const WidgetStatePropertyAll(
          Colors.black,
        ),
        overlayColor: const WidgetStatePropertyAll(Colors.orange),
        shadowColor: const WidgetStatePropertyAll(Colors.orange),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    }
    return ButtonStyle(
      padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
      elevation: WidgetStatePropertyAll(selected ? 4 : 1),
      backgroundColor: selected
          ? WidgetStatePropertyAll(Colors.grey.shade500)
          : WidgetStatePropertyAll(Colors.grey.shade50),
      minimumSize: const WidgetStatePropertyAll(
        Size(75, 30),
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      maximumSize: const WidgetStatePropertyAll(
        Size(200, 34),
      ),
      foregroundColor: const WidgetStatePropertyAll(
        Colors.black,
      ),
      overlayColor: const WidgetStatePropertyAll(Colors.orange),
      shadowColor: const WidgetStatePropertyAll(Colors.orange),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      side: WidgetStatePropertyAll(
        BorderSide(
          color: selected ? Colors.lightBlue : Colors.grey.shade100,
        ),
      ),
    );
  }
}
