import 'package:auto_size_text/auto_size_text.dart';
import 'package:comfortex_ai/layout/components/common/title_widget.dart';
import 'package:flutter/material.dart';

///The widget on the bottom of the DesktopScreen1.
class BottomWidget extends StatefulWidget {
  ///Default constructor for the BottomWidget.
  const BottomWidget({super.key});

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

/// the Fit enum  and Layers now are used for choice making which updates your
/// screen based on the choice
enum Fit { fit, loose }

///enum Layers which are now used for choice making and updating your screen.
enum Layers { one, two }

///A class to store chosen Enum property.
class _GarmentProperties {
  _GarmentProperties({Fit? fit,Layers? layers}): _fit = fit, _layers = layers;

  Fit? _fit;
  Layers? _layers;

  @override
  String toString() {
    return 'Garment Properties: $_fit, $_layers';
  }
}

///enums which are now used for choice making and updating your screen.
enum WorkIntensity { low, moderate, intense }

///enums which are now used for choice making and updating your screen.
enum Purpose { sport, protection }

///enums which are now used for choice making and updating your screen.
enum Scenario { indoors, outdoors }

///A basic class to store chosen Enum property.
class _ActivitySettings {
  _ActivitySettings({
    WorkIntensity? workIntensity,
    Purpose? purpose,
    Scenario? scenario,
  })  : _scenario = scenario,
        _purpose = purpose,
        _workIntensity = workIntensity;
  WorkIntensity? _workIntensity;
  Purpose? _purpose;
  Scenario? _scenario;

  @override
  String toString() {
    return 'Activity Settings: $_workIntensity, $_purpose, $_scenario';
  }
}

class _BottomWidgetState extends State<BottomWidget> {
  _ActivitySettings activitySettings = _ActivitySettings();
  _GarmentProperties garmentProperties = _GarmentProperties();
  int _temperature = 20;
  int _humidity = 50;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Flexible(
                flex: 3,
                child: TitleWidget(
                  iconPath: 'assets/icons/Shirt_2.png',
                  title: 'Garment Properties',
                ),
              ),
              Flexible(
                flex: 2,
                child: _subGroupTitle(
                  'Fit',
                ),
              ),
              Flexible(
                flex: 2,
                child: _buildFlexibleRadioButtons(
                    Fit.values, garmentProperties._fit, (newValue) {
                  setState(() {
                    garmentProperties._fit = newValue;
                  });
                }),
              ),
              Flexible(
                flex: 2,
                child: _subGroupTitle(
                  'Layers',
                ),
              ),
              Flexible(
                flex: 2,
                child: _buildFlexibleRadioButtons(
                    Layers.values, garmentProperties._layers, (newValue) {
                  setState(() {
                    garmentProperties._layers = newValue;
                  });
                }),
              ),
            ],
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Flexible(
                flex: 3,
                child: TitleWidget(
                  iconPath: 'assets/icons/17.png',
                  title: 'Activity Settings',
                ),
              ),
              Flexible(
                flex: 2,
                child: _subGroupTitle(
                  'Work Intensity',
                ),
              ),
              Flexible(
                flex: 2,
                child: _buildFlexibleRadioButtons(
                  WorkIntensity.values,
                  activitySettings._workIntensity,
                  (newValue) {
                    setState(() {
                      activitySettings._workIntensity = newValue;
                    });
                  },
                ),
              ),
              Flexible(
                flex: 2,
                child: _subGroupTitle(
                  'Purpose',
                ),
              ),
              Flexible(
                flex: 2,
                child: _buildFlexibleRadioButtons(
                  Purpose.values,
                  activitySettings._purpose,
                  (newValue) {
                    setState(
                      () {
                        activitySettings._purpose = newValue;
                      },
                    );
                  },
                ),
              ),
              Flexible(
                flex: 2,
                child: _subGroupTitle(
                  'Scenario',
                ),
              ),
              Flexible(
                flex: 2,
                child: _buildFlexibleRadioButtons(
                  Scenario.values,
                  activitySettings._scenario,
                  (newValue) {
                    setState(
                      () {
                        activitySettings._scenario = newValue;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Flexible(
                flex: 3,
                child: TitleWidget(
                  iconPath: 'assets/icons/18.png',
                  title: 'Environmental Variables',
                ),
              ),
              Flexible(
                flex: 2,
                child: SizedBox(
                  width: 400,
                  child: _buildSlider(
                    'Temperature (°C)',
                    _temperature,
                    -20,
                    50,
                    (newValue) {
                      setState(() {
                        _temperature = newValue.round();
                      });
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: SizedBox(
                  width: 400,
                  child: _buildSlider(
                    'Humidity (%)',
                    _humidity,
                    0,
                    100,
                    (newValue) {
                      setState(() {
                        _humidity = newValue.round();
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildSlider(
    String title,
    int value,
    int min,
    int max,
    ValueChanged<double> onChanged,
  ) {
    return Column(//TODO the 3rd column text is going down how to fix it?
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 2,
          child: _subGroupTitle(title, strutHeight: 1),
        ),
        Flexible(
          flex: 2,
          child: Slider(
            key: Key(title),
            label: title,
            value: value.toDouble(),
            min: min.toDouble(),
            max: max.toDouble(),
            onChanged: onChanged,
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
            alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(right: 24),
              child: AutoSizeText('$value', textAlign: TextAlign.end,),),
        ),
      ],
    );
  }

  ///Another refactored piece of code now for easier readability, updates and
  ///maintainability
  Row _buildFlexibleRadioButtons<T extends Enum>(
    List<T> values,
    T? groupValue,
    void Function(T?)? onChanged,
  ) {
    var count = 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final T val in values)
          Flexible(
            child: SizedBox(
              width: ++count > 1 ? 140 : 105,
              child: RadioListTile<T>(
                activeColor: Colors.black,
                hoverColor: Colors.grey[300],
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: AutoSizeText(
                  val.name,
                  style: const TextStyle(fontSize: 16),
                  minFontSize: 14,
                  overflow: TextOverflow.visible,
                  maxLines: 2,
                ),
                value: val,
                groupValue: groupValue,
                onChanged: onChanged,
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
      style: const TextStyle(fontSize: 20),
      overflow: TextOverflow.clip,
      strutStyle: StrutStyle(height: strutHeight ?? 2),
      minFontSize: 16,
      maxLines: 2,
    );
  }

  get _temperatureValue => _temperature;
  get _humidityValue => _humidity;
}
