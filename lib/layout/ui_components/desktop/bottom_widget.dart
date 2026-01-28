import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:comfortex_ai/layout/ui_components/common/MyCustomScrollBehavior.dart';
import 'package:comfortex_ai/layout/ui_components/common/title_widget.dart';
import 'package:comfortex_ai/model/Properties_v2.dart';

import 'package:comfortex_ai/utils/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

///The widget on the bottom of the DesktopScreen1.
class BottomWidget extends StatefulWidget {
  ///Default constructor for the BottomWidget.
  BottomWidget(this.properties, {super.key});
  PropertiesV2 properties;

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  ScrollController scroller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, restrict) {
        final width = restrict.maxWidth;
        final pageWidth = width < 800 ? width * 0.45 : width * 0.3333;
        return Scrollbar(
          thickness: width < 800 ? 9 : 0,
          controller: scroller,
          scrollbarOrientation: ScrollbarOrientation.bottom,
          child: Listener(
            onPointerSignal: (pointerSignal) {
              // Check if the event is a scroll event.
              if (pointerSignal is PointerScrollEvent) {
                // Get the vertical scroll amount from the mouse wheel.
                final double scrollAmount = pointerSignal.scrollDelta.dy;
                // Manually move the horizontal scroll view by that amount.
                scroller.jumpTo(
                  scroller.offset + scrollAmount / 3,
                );
              }
            },
            child: ScrollConfiguration(
              behavior: MyCustomScrollBehavior(),
              child: SingleChildScrollView(
                controller: scroller,
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width > 920 ? pageWidth : pageWidth * 0.79,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Flexible(
                            child: TitleWidget(
                              iconPath: 'assets/icons/shirt_2.png',
                              title: 'Garment Properties',
                              center: false,
                            ),
                          ),
                          const Gap(24),
                          Flexible(
                            child: _subGroupTitle(
                              'Fit',
                            ),
                          ),
                          Flexible(
                            child: _buildFlexibleRadioButtons(
                                widget.properties.fitList,
                                [],
                                widget.properties.fit,
                                    (newValue) {
                              setState(() {
                                widget.properties.fit = newValue;
                                if (widget.properties.fit != null &&
                                    widget.properties.layers != null &&
                                    width < 800) {
                                  scroller.animateTo(width / 3,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.linear);
                                }
                              });
                            }),
                          ),
                          Flexible(
                            child: _subGroupTitle(
                              'Layers',
                            ),
                          ),
                          Flexible(
                            child: _buildFlexibleRadioButtons(
                                widget.properties.layersList,
                                <String>[
                                  'two', 'Two'
                                  //, 'Three'
                                ],
                                widget.properties.layers,
                                (newValue) {
                              setState(() {
                                widget.properties.layers = newValue;
                                if (widget.properties.fit != null &&
                                    widget.properties.layers != null &&
                                    width < 800) {
                                  scroller.animateTo(width / 3.2,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.linear);
                                }
                              });
                            }),
                          ),
                          if (width >= 1080) const Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width > 920 ? pageWidth : pageWidth * 1.23,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Flexible(
                            child: TitleWidget(
                              iconPath: 'assets/icons/17.png',
                              title: 'Activity Settings',
                              center: false,
                            ),
                          ),
                          const Gap(8),
                          Flexible(
                            child: _subGroupTitle(
                              'Work Intensity',
                            ),
                          ),
                          Flexible(
                            child: _buildFlexibleRadioButtons(
                              widget.properties.workIntensityList,
                              ['low', 'high', 'Light', 'Heavy',],
                              widget.properties.workIntensity,
                              (newValue) {
                                setState(() {
                                  widget.properties.workIntensity = newValue;
                                });
                              },
                            ),
                          ),
                          Flexible(
                            child: _subGroupTitle(
                              'Purpose',
                            ),
                          ),
                          Flexible(
                            child: _buildFlexibleRadioButtons(
                              widget.properties.purposeList,
                              ['Casual', ],
                              widget.properties.purpose,
                              (newValue) {
                                setState(
                                  () {
                                    widget.properties.purpose = newValue;
                                  },
                                );
                              },
                            ),
                          ),
                          Flexible(
                            child: _subGroupTitle(
                              'Scenario',
                            ),
                          ),
                          Flexible(
                            child: _buildFlexibleRadioButtons(
                              widget.properties.scenarioList,
                              ['outdoors', 'Outdoors'],
                              widget.properties.scenario,
                              (newValue) {
                                setState(
                                  () {
                                    widget.properties.scenario = newValue;
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: pageWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Flexible(
                            child: TitleWidget(
                              center: false,
                              iconPath: 'assets/icons/18.png',
                              title: 'Environmental Variables',
                            ),
                          ),
                          const Gap(24),
                          Flexible(
                            child: _buildSlider(
                              'Temperature (°C)',
                              widget.properties.temperature!,
                              widget.properties.min_temperature,
                              widget.properties.max_temperature,
                              (newValue) {
                                setState(() {
                                  widget.properties.temperature =
                                      newValue.round();
                                });
                              },
                            ),
                          ),
                          Flexible(
                            child: _buildSlider(
                              'Humidity (%)',
                              widget.properties.humidity!,
                              widget.properties.min_humidity,
                              widget.properties.max_humidity,
                              (newValue) {
                                setState(() {
                                  widget.properties.humidity = newValue.round();
                                });
                              },
                            ),
                          ),
                          //if (width >= 1080) const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Column _buildSlider(
    String title,
    int value,
    int min,
    int max,
    ValueChanged<double> onChanged,
  ) {
    return Column(
      //TODO the 3rd column text is going down how to fix it?
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: _subGroupTitle(title, strutHeight: 1),
        ),
        Flexible(
          child: Slider(
            padding: EdgeInsets.zero,
            key: Key(title),
            label: title,
            value: value.toDouble(),
            min: min.toDouble(),
            max: max.toDouble(),
            onChanged: onChanged,
          ),
        ),
        Flexible(
          child: Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.only(right: 32),
            child: AutoSizeText(
              '$value',
              style: GoogleFonts.roboto(textStyle: Style.bodyTextDesktop),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ],
    );
  }

  ///Another refactored piece of code now for easier readability, updates and
  ///maintainability
  Row _buildFlexibleRadioButtons(
    List<String> values,
    List<String> greyedOutValues,
    String? groupValue,
    void Function(String?)? onChanged,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final String val in values)
            Flexible(
              child: SizedBox(
                width: 160,
                height: 100,
                child: RadioListTile<String>(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: Colors.black,
                  hoverColor: Colors.lightGreen,
                  autofocus: true,
                  dense: true,
                  visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity),
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    val.toLowerCase(),
                    style: GoogleFonts.roboto(
                      textStyle: Style.bodyTextDesktop,
                    ),
                    overflow: TextOverflow.visible,
                    maxLines: 2,
                  ),
                  value: val,
                  groupValue: groupValue,
                  onChanged: onChanged,
                  enabled: !greyedOutValues.contains(val),
                ),
              ),
            ),
      ],
    );
  }

  ///Refactoring...
  AutoSizeText _subGroupTitle(
    String text, {
    double? strutHeight,
  }) {
    return AutoSizeText(
      text,
      style: GoogleFonts.roboto(textStyle: Style.desktopSubtitle, height: 1),
      overflow: TextOverflow.visible,
      strutStyle: StrutStyle(height: strutHeight ?? 2),
      minFontSize: 18,
      maxLines: 2,
    );
  }
}
