import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


///The widget on the bottom of the DesktopScreen1.
class BottomWidget extends StatefulWidget {
  const BottomWidget({super.key});

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

/// the Fit enum  and Layers now are used for choice making which updates your screen based
/// on the choice
enum Fit { fit, loose }

enum Layers { one, two }

///A class to store chosen Enum property.
class _GarmentProperties {
  Fit? fit;
  Layers? layers;

  _GarmentProperties({this.fit, this.layers});

  @override
  String toString() {
    return "Garment Properties: $fit, $layers";
  }
}

///enums which are now used for choice making and updating your screen.
enum WorkIntensity { low, moderate, intense }

enum Purpose { sport, protection }

enum Scenario { indoors, outdoors }

///A basic class to store chosen Enum property.
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildColumnTitleListTile(
                'icons/Shirt_2.png',
                "Garment Properties",
              ),
              buildBoxGroupTitle(
                "Fit",
              ),
              buildFlexibleRadioButtons(
                Fit.values,
                garmentProperties.fit,
                  (newValue) {
                    setState(() {
                      garmentProperties.fit = newValue;
                    });
                  }
              ),
              buildBoxGroupTitle(
                "Layers",
              ),
              buildFlexibleRadioButtons(
                Layers.values,
                garmentProperties.layers,
                      (newValue) {
                    setState(() {
                      garmentProperties.layers = newValue;
                    });
                  }
              ),
            ],
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildColumnTitleListTile(
                'icons/17.png',
                'Activity Settings',
              ),
              buildBoxGroupTitle(
                'Work Intensity',
              ),
              buildFlexibleRadioButtons(
                WorkIntensity.values,
                activitySettings.workIntensity,
                    (newValue) {
                  setState(() {
                    activitySettings.workIntensity = newValue;
                  });
                },
              ),
              buildBoxGroupTitle(
                "Purpose",
              ),
              buildFlexibleRadioButtons(
                Purpose.values,
                activitySettings.purpose,
                    (newValue) {
                  setState(() {
                    activitySettings.purpose = newValue;
                  },);
                },
              ),
              buildBoxGroupTitle(
                "Scenario",
              ),
              buildFlexibleRadioButtons(
                Scenario.values,
                activitySettings.scenario,
                    (newValue) {
                  setState(() {
                    activitySettings.scenario = newValue;
                  },);
                },
              ),
            ],
          ),
        ),
        Expanded(child: Container(color: Colors.black,),),],
    );
  }


  ///A refactored ListTile on top of each Column to give an idea of what the
  ///Column is about
  Flexible buildColumnTitleListTile(
      String assetName, final String columnTitle) {
    return Flexible(
      flex: 3,
      child: ListTile(
        hoverColor: Colors.orange,
        contentPadding: EdgeInsets.zero,
        leading: Image.asset(
          assetName,
          fit: BoxFit.contain,
          width: 48,
          height: 48,
        ),
        title: AutoSizeText(
          columnTitle,
          style: const TextStyle(fontSize: 24, color: Colors.lightBlue),
        ),
      ),
    );
  }

  ///Another refactored piece of code now for easier readability, updates and
  ///maintainability.
  Flexible buildFlexibleRadioButtons<T extends Enum>(
    List<T> values,
    T? groupValue,
      Function(T?)? onChanged,
  ) {
    return Flexible(
      flex: 2,
      child: Row(
        children: [
          for (T val in values)
            Flexible(
              child: SizedBox(
                width: 200,
                child: RadioListTile(
                  title: AutoSizeText(
                    val.name,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  value: val,
                  groupValue: groupValue,
                  //TODO: setState in the main code
                  onChanged: onChanged
                ),
              ),
            ),
        ],
      ),
    );
  }

  ///Refactoring...
  Flexible buildBoxGroupTitle(
    String text, {
    double? strutHeight,
  }) {
    return Flexible(
      flex: 2,
      child: AutoSizeText(
        text,
        style: const TextStyle(fontSize: 20.0),
        overflow: TextOverflow.fade,
        strutStyle: StrutStyle(height: strutHeight ?? 2),
        minFontSize: 16.0,
      ),
    );
  }
}
