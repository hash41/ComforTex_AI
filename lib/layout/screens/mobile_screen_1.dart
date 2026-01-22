import 'dart:async';
import 'dart:math';

import 'package:comfortex_ai/layout/ui_components/common/img_container.dart';
import 'package:comfortex_ai/layout/ui_components/common/page_builder.dart';
import 'package:comfortex_ai/layout/ui_components/common/title_widget.dart';
import 'package:comfortex_ai/layout/ui_components/common/top_bar.dart';
import 'package:comfortex_ai/utils/assets.dart';
import 'package:comfortex_ai/model/properties.dart';
import 'package:comfortex_ai/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

///MobileScreen1 displays the Mobile version screen1.
class MobileScreen1 extends StatefulWidget {
  Properties properties;

  ///Constructor for MobileScreen1
  MobileScreen1(this.properties, {super.key});

  @override
  State<MobileScreen1> createState() => _MobileScreen1State();
}

class _MobileScreen1State extends State<MobileScreen1>
    with TickerProviderStateMixin {
  late Properties properties = widget.properties;
  static const String _title = 'Garment Type';
  static const String _ChooseOne = 'Choose one of these';
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late AnimationController _controller2;
  late Animation<Color?> _colorAnimation2;
  bool _showhint = false;
  double _a = 0;

  ///A method to change ShirtType and update the screen.
  void changeShirtType(ShirtType shirtType) {
    setState(() {
      properties.shirtType = shirtType;
      setDescription(null);
    });
    if (!_controller.isForwardOrCompleted) {
      _controller.forward();
    }
  }

  void setDescription(String? description) {
    if (!_controller2.isForwardOrCompleted && description != null) {
      _controller2.forward();
    } else if (_controller2.isForwardOrCompleted && description == null) {
      _controller2.reverse();
    }
    setState(() {
      properties.material = description;
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _colorAnimation = ColorTween(
      begin: Colors.purple.shade50,
      end: Colors.green.shade100,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _colorAnimation2 = ColorTween(
      begin: Colors.purple.shade50,
      end: Colors.green.shade100,
    ).animate(_controller2)
      ..addListener(() {
        setState(() {});
      });
    if (properties.shirtType == null) {
      Timer(const Duration(milliseconds: 5000), () {
        if (mounted) {
          setState(() {
            _showhint = true;
            _a = 0.3;
          });
        }
        Timer(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _showhint = false;
              _a = 0.1;
            });
          }
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.portrait) {
            return Scaffold(
              appBar: TopBar(
                height: Style.topBarHeightPortrait,
                loggedIn: true,options: true,),
              body: Column(
                children: <Widget>[
                  Spacer(),
                  Expanded(
                    flex: 6,
                    child: Stack(
                      children: [
                        buildContainerAnimated(
                          properties.shirtType,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Flexible(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: TitleWidget(
                                    iconPath: Assets.T_SHIRT_ICON,
                                    title: _title,
                                    isMobile: true,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 72),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: ImgContainer(
                                          selected: properties.shirtType ==
                                              ShirtType.polo,
                                          onTap: () {
                                            changeShirtType(ShirtType.polo);
                                          },
                                          child: Image.asset(
                                            fit: BoxFit.scaleDown,
                                            Assets.POLO_ICON,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: ImgContainer(
                                          selected: properties.shirtType ==
                                              ShirtType.t_shirt,
                                          onTap: () {
                                            changeShirtType(ShirtType.t_shirt);
                                          },
                                          child: Image.asset(
                                            fit: BoxFit.scaleDown,
                                            Assets.SHIRT_SELECT,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                _ChooseOne,
                                style: GoogleFonts.roboto(
                                  textStyle: Style.captionTextMobile,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedRotation(
                          turns: _a,
                          duration: Duration(milliseconds: 900),
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 1300),
                            opacity: _showhint ? 1.0 : 0.0,
                            child: const Center(
                              child: Icon(
                                Icons
                                    .touch_app_outlined, // A great built-in icon for this
                                color: Colors.red,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate(key: ValueKey(orientation)).shimmer(
                        duration: const Duration(milliseconds: 700),
                      ),
                  const Spacer(),
                  if (properties.shirtType != null)
                    Expanded(
                      flex: 8,
                      child: buildContainerAnimated(
                        properties.material,
                        Column(
                          children: [
                            const SizedBox(
                              width: 200,
                              height: 72,
                              child: TitleWidget(
                                iconPath: Assets.MATERIAL_ICON,
                                title: 'Material',
                                isMobile: true,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: PageBuilder(
                                  properties,
                                  setDescription,
                                  key: ValueKey(properties.shirtType!),
                                  mobileWidget: true,
                                ),
                              ),
                            ),
                            Text(
                              _ChooseOne,
                              style: GoogleFonts.roboto(
                                textStyle: Style.captionTextMobile,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .animate(key: ValueKey(properties.shirtType == null))
                        .scaleY(
                          duration: const Duration(milliseconds: 700),
                        )
                  else
                    const Spacer(
                      flex: 8,
                    ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              appBar: TopBar(loggedIn: true, options: true,
              height: Style.topBarHeightLandscape,
              ), //MediaQuery.sizeOf(context).height * 0.15
              body: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Stack(
                        children: [
                          buildContainerAnimated(
                            properties.shirtType,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Flexible(
                                  child: TitleWidget(
                                    iconPath: Assets.T_SHIRT_ICON,
                                    title: 'Garment Type',
                                    isLandscape: true,
                                    isMobile: true,
                                  ),
                                ),
                                const Gap(
                                  4,
                                ),
                                Flexible(
                                  flex: 6,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: ImgContainer(
                                          selected: properties.shirtType ==
                                              ShirtType.polo,
                                          onTap: () {
                                            changeShirtType(ShirtType.polo);
                                          },
                                          child: Image.asset(
                                            fit: BoxFit.scaleDown,
                                            'assets/icons/polo.png',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Flexible(
                                        child: ImgContainer(
                                          selected: properties.shirtType ==
                                              ShirtType.t_shirt,
                                          onTap: () {
                                            changeShirtType(ShirtType.t_shirt);
                                          },
                                          child: Image.asset(
                                            fit: BoxFit.scaleDown,
                                            'assets/icons/t_shirt.png',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  _ChooseOne,
                                  style: GoogleFonts.roboto(
                                    textStyle: Style.captionTextMobile,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ).animate(key: ValueKey(orientation)).flipH(
                          duration: const Duration(milliseconds: 800),
                        ),
                    Gap(6),
                    if (properties.shirtType != null)
                      Expanded(
                        flex: 5,
                        child: buildContainerAnimated(
                          properties.material,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              const Flexible(
                                child: TitleWidget(
                                  iconPath: Assets.MATERIAL_ICON,
                                  title: 'Material',
                                  isLandscape: true,
                                  isMobile: true,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Flexible(
                                flex: 6,
                                child: PageBuilder(
                                  //TODO: Should we add a stream and listen to it and push the screen based on that ?
                                  properties, setDescription,
                                  key: ValueKey(
                                    properties.shirtType!,
                                  ),
                                  mobileWidget: true,
                                ),
                              ),
                              Text(
                                _ChooseOne,
                                style: GoogleFonts.roboto(
                                  textStyle: Style.captionTextMobile,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      )
                    else
                      const Spacer(
                        flex: 4,
                      ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Container buildContainerAnimated(dynamic? prop, Widget c) {
    return Container(
        decoration: BoxDecoration(
            color: prop is ShirtType ? _colorAnimation.value : _colorAnimation2.value,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                blurRadius: prop == null ? 0 : 12,
              )
            ]),
        child: c);
  }
}
