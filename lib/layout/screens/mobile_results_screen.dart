import 'package:comfortex_ai/layout/ui_components/common/top_bar.dart';
import 'package:comfortex_ai/layout/ui_components/mobile/back_button.dart';
import 'package:comfortex_ai/model/Properties_v2.dart';
import 'package:comfortex_ai/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

/// Renders results on a Mobile screen
class MobileResultsScreen extends StatelessWidget {
  /// Constructor taking the properties already selected for display purposes
  const MobileResultsScreen(this.properties, {super.key});

  /// properties selected, passed in the widget constructor
  final PropertiesV2 properties;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OrientationBuilder(
        builder: (context, Orientation orientation) {
          if (orientation == Orientation.portrait) {
            return Scaffold(
              appBar: TopBar(
                height: Style.topBarHeightPortrait,
                leading: const MaterialBackButton(),
                loggedIn: true,
                options: true,
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildCriteriaColumn(
                          'Thermal',
                          properties.prediction?.thermal,
                        ),
                        const Flexible(
                          child: Gap(14),
                        ),
                        buildCriteriaColumn(
                          'Moisture',
                          properties.prediction?.moisture,
                        ),
                        const Flexible(
                          child: Gap(14),
                        ),
                        buildCriteriaColumn(
                          'Comfort',
                          properties.prediction?.comfort,
                        ),
                      ],
                    ),
                    const Gap(24),
                    const Divider(
                      height: 3,
                      color: Colors.redAccent,
                    ),
                    const Gap(24),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '[selection]',
                        style: GoogleFonts.roboto(
                          textStyle: Style.mobileTitle,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    const Flexible(child: Gap(24)),
                    Flexible(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          for (final property in properties.getProperties())
                            Text(
                              property.toString(),
                              style: GoogleFonts.roboto(
                                textStyle: Style.captionTextMobile.copyWith(
                                  fontSize: 11,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Gap(24),
                  ],
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
              body: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Comfort Prediction',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                textStyle: Style.mobileTitle,
                              ),
                            ),
                          ),
                          const Gap(24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: buildCriteriaColumn(
                                  'Thermal',
                                  properties.prediction?.thermal,
                                ),
                              ),
                              const Gap(
                                24,
                              ),
                              Flexible(
                                child: buildCriteriaColumn(
                                  'Moisture',
                                  properties.prediction?.moisture,
                                ),
                              ),
                              const Gap(
                                24,
                              ),
                              Flexible(
                                child: buildCriteriaColumn(
                                  'Comfort',
                                  properties.prediction?.comfort,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Container(
                          //   decoration: BoxDecoration(
                          //     color: Colors.grey.shade200,
                          //     borderRadius: BorderRadius.circular(6),
                          //   ),
                          //   child: Text(
                          //     'Key Factors',
                          //     style: Style.mobileTitle,
                          //   ),
                          // ),
                          // const Gap(24),
                          // Flexible(
                          //   child: Row(
                          //     mainAxisAlignment:
                          //     MainAxisAlignment.spaceEvenly,
                          //     children: [
                          //       for (final factor in properties.prediction
                          //           ?.keyFactors ?? [])
                          //         Text(
                          //           factor.toString(),
                          //           style: Style.resultTextMobile,
                          //         ),
                          //     ],
                          //   ),
                          // ),
                          const Gap(24),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '[selection]',
                              style: GoogleFonts.roboto(
                                textStyle: Style.mobileTitle,
                              ),
                            ),
                          ),
                          const Gap(24),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (final property in properties.getProperties())
                                Text(
                                  '$property',
                                  style: GoogleFonts.roboto(
                                    textStyle: Style.captionTextMobile,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
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

  ///Builds a column of  passed criteria, with its value below it
  Column buildCriteriaColumn(String criteria, String? value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            criteria,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              textStyle: Style.mobileTitle,
            ),
          ),
        ),
        const Gap(20),
        Text(
          value ?? '',
          style: GoogleFonts.roboto(
            textStyle: Style.resultTextMobile,
          ),
        ),
      ],
    );
  }
}
