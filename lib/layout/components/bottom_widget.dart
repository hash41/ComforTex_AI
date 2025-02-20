import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BottomWidget extends StatefulWidget {
  const BottomWidget({super.key});

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

enum Fit { fit, loose }

enum Layers { one, two }

class _GarmentProperties {
  Fit? fit;
  Layers? layers;

  _GarmentProperties({this.fit, this.layers});

  @override
  String toString() {
    return "Garment Properties: $fit, $layers";
  }
}

enum WorkIntensity { low, moderate, intense }

enum Purpose { sport, protection }

enum Scenario { indoors, outdoors }

class _ActivitySettings {
  WorkIntensity? workIntensity;
  Purpose? purpose;
  Scenario? scenario;

  _ActivitySettings({this.workIntensity, this.purpose, this.scenario});

  @override
  String toString() {
    return "Activity Settings: $workIntensity, $purpose, $scenario";
  }
}

class _BottomWidgetState extends State<BottomWidget> {
  _ActivitySettings activitySettings =
      _ActivitySettings(workIntensity: null, purpose: null, scenario: null);
  _GarmentProperties garmentProperties =
      _GarmentProperties(fit: null, layers: null);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ListTile(
                  leading: Image.asset(
                    'icons/Shirt_2.png',
                    fit: BoxFit.contain,
                    width: 48,
                    height: 48,
                  ),
                  title: const Flexible(
                    child: AutoSizeText(
                      "Garment Properties",style: TextStyle(fontSize: 24, color: Colors.lightBlue),
                    ),
                  ),
                ),
              ),
              const Flexible(
                child: AutoSizeText(
                  "Fit",
                  style: TextStyle(fontSize: 20),
                  minFontSize: 6,
                  overflow: TextOverflow.visible,
                ),
              ),
              Flexible(
                child: Row(
                  children: [
                    for (Fit fitValue in Fit.values)
                      Flexible(
                        child: RadioListTile<Fit?>(
                          title: Flexible(child: AutoSizeText(fitValue.name)),
                          value: fitValue,
                          groupValue: garmentProperties.fit,
                          onChanged: (fit) {
                            garmentProperties.fit = fit;
                          },
                        ),
                      ),
                  ],
                ),
              ),
              const Flexible(
                child: AutoSizeText(
                  "Layers",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Flexible(
                child: Row(
                  spacing: 0,
                  textDirection: TextDirection.ltr,
                  children: [
                    for (Layers layersValue in Layers.values)
                      Flexible(
                        child: RadioListTile<Layers?>(
                          title: AutoSizeText(layersValue.name),
                          value: layersValue,
                          groupValue: garmentProperties.layers,
                          onChanged: (layers) {
                            garmentProperties.layers = layers;
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ListTile(
                  leading: Image.asset(
                    'icons/17.png',
                    width: 48,
                    height: 48,
                    fit: BoxFit.contain,
                  ),
                  title: const AutoSizeText(
                    "Activity Settings", style: TextStyle(fontSize: 24, color: Colors.lightBlue),
                  ),
                ),
              ),
              const Flexible(
                child: AutoSizeText(
                  "Work Intensity",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Flexible(
                child: Row(
                  children: [
                    for (WorkIntensity workIntensity in WorkIntensity.values)
                      Flexible(
                        child: RadioListTile<WorkIntensity?>(
                          title: AutoSizeText(workIntensity.name),
                          value: workIntensity,
                          groupValue: activitySettings.workIntensity,
                          onChanged: (activity) {
                            setState(() {
                              activitySettings.workIntensity = activity;
                            });
                          },
                        ),
                      ),
                  ],
                ),
              ),
              const Flexible(child: AutoSizeText("Purpose",style: TextStyle(fontSize: 20),)),
              Flexible(
                child: Row(
                  children: [
                    for (Purpose purpose in Purpose.values)
                      Flexible(
                        child: RadioListTile(
                          title: Flexible(child: AutoSizeText(purpose.name,)),
                          value: purpose,
                          groupValue: activitySettings.purpose,
                          onChanged: (p) {
                            setState(() {
                              activitySettings.purpose = p;
                            });
                          },
                        ),
                      ),
                  ],
                ),
              ),
              const Flexible(child: AutoSizeText("Scenario",style: TextStyle(fontSize: 20),)),
              Flexible(
                child: Row(
                  children: [
                    for (Scenario scenario in Scenario.values)
                      Flexible(
                        child: RadioListTile(
                          title: Flexible(child: AutoSizeText(scenario.name,)),
                          value: scenario,
                          groupValue: activitySettings.scenario,
                          onChanged: (scn) {
                            setState(() {
                              activitySettings.scenario = scn;
                            });
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
