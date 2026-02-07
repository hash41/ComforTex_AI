import 'package:comfortex_ai/layout/ui_components/common/title_widget.dart';
import 'package:comfortex_ai/layout/ui_components/common/top_bar.dart';
import 'package:comfortex_ai/model/Properties_v2.dart';
import 'package:comfortex_ai/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

/// Results screen for desktop
class DesktopResultsScreen extends StatelessWidget {
  /// Default constructor
  const DesktopResultsScreen(this.properties, {super.key});

  /// attribute carrying the selections of user
  final PropertiesV2 properties;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: TopBar(
        height:
            height < 1200 ? Style.topBarHeightDesktop : Style.topBarOver1200,
        leading: Center(
          child: MaterialButton(
            height: 48,
            color: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Back to Selection',
              style: GoogleFonts.roboto(
                textStyle: Style.buttonTextDesktop,
              ),
            ),
          ),
        ),
        loggedIn: true,
        options: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(32),
                      const Flexible(
                        child: TitleWidget(title: 'Comfort Prediction'),
                      ),
                      const Gap(16),
                      Row(
                        children: [
                          Expanded(
                            child: buildCriteriaRow(
                              'Thermal',
                              properties.prediction?.thermal ?? '',
                            ),
                          ),
                          Expanded(
                            child: buildCriteriaRow(
                              'Moisture',
                              properties.prediction?.moisture ?? '',
                            ),
                          ),
                          Expanded(
                            child: buildCriteriaRow(
                              'Comfort',
                              properties.prediction?.comfort ?? '',
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
          if (height > 500)
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (width > 1420) const Spacer() else const Gap(32),
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Flexible(
                          child: TitleWidget(
                            title: 'Relevant features',
                            center: false,
                          ),
                        ),
                        const Gap(16),
                        Text(
                          'If the arrow is up, it helps comfort. If the arrow '
                          'is down, it reduces comfort.',
                          style: GoogleFonts.roboto(
                            textStyle: Style.captionTextDesktop.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const Gap(16),
                        for (final key
                            in properties.prediction?.keyFactors?.keys ?? [])
                          Row(
                            children: [
                              SizedBox(
                                width: 240,
                                child: Text(
                                  key != null ? '$key:' : '',
                                  style: GoogleFonts.roboto(
                                    textStyle: Style.bodyTextDesktop,
                                  ),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              const Gap(16),
                              SizedBox(
                                width: 50,
                                child: Text(
                                  textAlign: TextAlign.right,
                                  properties.prediction?.keyFactors?[key]?[0]
                                          .toString() ??
                                      '',
                                  style: GoogleFonts.roboto(
                                    textStyle: Style.bodyTextDesktop.copyWith(
                                      textBaseline: TextBaseline.alphabetic,
                                    ),
                                  ),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              const Gap(16),
                              properties.prediction?.keyFactors?[key]?[1]
                                  as Icon,
                            ],
                          ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  if (width > 1420) const Spacer() else const Gap(8),
                  if (width > 800)
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Flexible(
                            child: TitleWidget(
                              title: 'Your selection',
                              center: false,
                            ),
                          ),
                          const Gap(24),
                          Expanded(
                            child: Wrap(
                              spacing: 48,
                              runSpacing: 36,
                              children: [
                                _buildPropertyColumn(
                                  'Shirt Type',
                                  properties.shirtType!.name,
                                ),
                                _buildPropertyColumn(
                                  'Material',
                                  properties.material!,
                                ),
                                _buildPropertyColumn(
                                  'Layers',
                                  properties.layers!,
                                ),
                                _buildPropertyColumn(
                                  'purpose',
                                  properties.purpose!,
                                ),
                                _buildPropertyColumn('Fit', properties.fit!),
                                _buildPropertyColumn(
                                  'Temperature',
                                  properties.temperature.toString(),
                                ),
                                _buildPropertyColumn(
                                  'Humidity',
                                  properties.humidity.toString(),
                                ),
                                _buildPropertyColumn(
                                  'Work Intensity',
                                  properties.workIntensity!,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (width > 1420) const Spacer() else const Gap(24),
                ],
              ),
            ),
        ],
      ),
    );
  }

  /// A method which is capable of helping to refactor the UI
  Column _buildPropertyColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(textStyle: Style.bodyTextDesktop),
        ),
        Text(
          value,
          style: GoogleFonts.roboto(textStyle: Style.resultTextDesktop),
        ),
      ],
    );
  }

  /// A method which is capable of helping us refactor the UI
  Column buildCriteriaRow(String criteria, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          criteria,
          style: GoogleFonts.roboto(textStyle: Style.captionTextDesktop),
        ),
        const Gap(10),
        Text(
          value,
          maxLines: 1,
          style: GoogleFonts.roboto(
            textStyle: Style.desktopTitle
                .copyWith(color: Colors.orange, overflow: TextOverflow.clip),
          ),
        ),
      ],
    );
  }
}
