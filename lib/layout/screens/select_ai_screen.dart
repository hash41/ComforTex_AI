import 'package:comfortex_ai/layout/screens/desktop_screen_1.dart';
import 'package:comfortex_ai/layout/screens/mobile_screen_1.dart';
import 'package:comfortex_ai/layout/screens/screen.dart';
import 'package:comfortex_ai/layout/ui_components/common/top_bar.dart';
import 'package:comfortex_ai/model/Properties_v2.dart';
import 'package:comfortex_ai/model/ai_version.dart';
import 'package:comfortex_ai/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// A widget rendered for the user to select an AI
class SelectAiScreen extends StatelessWidget {
  /// Default constructor
  SelectAiScreen({super.key});

  /// A properties containing wide range of objects
  final PropertiesV2 properties = PropertiesV2();

  /// A notifier to help display text in a stateless widget
  final ValueNotifier<String> message = ValueNotifier<String>('');

  /// AiVersionStore singleton
  final AiVersionStore aiDecider = AiVersionStore.instance;

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.sizeOf(context).height; //Can be final, because the
    //build method will run again after change of screen size..
    final orientation = MediaQuery.of(context).orientation;
    double topbarHeight;
    if (height < 650) {
      if (orientation == Orientation.portrait) {
        topbarHeight = Style.topBarHeightPortrait;
      } else {
        topbarHeight = Style.topBarHeightLandscape;
      }
    } else if (height > 650 && height < 1200) {
      topbarHeight = Style.topBarHeightDesktop;
    } else {
      topbarHeight = Style.topBarOver1200;
    }
    return SafeArea(
      child: Scaffold(
        appBar: TopBar(
          loggedIn: true,
          height: topbarHeight,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select an AI version:',
              style: Style.desktopSubtitle,
            ),
            const Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildMaterialButton(
                  AiVersion.one,
                  context,
                ),
                const Gap(27),
                buildMaterialButton(
                  AiVersion.two,
                  context,
                ),
                const Gap(27),
                buildMaterialButton(
                  AiVersion.twoDynamicProperties,
                  context,
                ),
              ],
            ),
            const Gap(12),
            ValueListenableBuilder<String>(
              valueListenable: message,
              builder: (_, value, __) => Text(
                value,
                style: Style.bodyTextDesktop.copyWith(
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Just a button refactored for this specific file
  MaterialButton buildMaterialButton(
    AiVersion ai,
    BuildContext context,
  ) {
    var generatedProperties = false;
    return MaterialButton(
      elevation: 12,
      hoverElevation: 24,
      hoverColor: Colors.black,
      color: Colors.blueAccent,
      height: MediaQuery.sizeOf(context).width > 500 ? 60 : 50,
      minWidth: MediaQuery.sizeOf(context).width > 500 ? 100 : 80,
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            16,
          ),
        ),
        borderSide: BorderSide(
          width: 0,
          color: Colors.lightBlueAccent,
        ),
      ),
      onPressed: () async {
        aiDecider.aiVersion = ai;
        if (ai == AiVersion.one) {
          generatedProperties = properties.generatePropertiesV1();
        } else if (ai == AiVersion.two) {
          generatedProperties = properties.generatePropertiesV2();
        } else {
          generatedProperties = await properties.generatePropertiesDynamic();
        }
        if (!generatedProperties) {
          message.value =
              "Couldn't generate properties, try a different version";
        } else {
          if (context.mounted) {
            await Navigator.push(
              context,
              MaterialPageRoute<Screen>(
                builder: (context) {
                  return Screen.build(
                    context,
                    desktopScreen: DesktopScreen1(properties),
                    mobileScreen: MobileScreen1(properties),
                  );
                },
              ),
            );
          }
        }
      },
      child: Text(
        ai == AiVersion.twoDynamicProperties ? 'two+' : ai.name,
        style: Style.buttonTextDesktop.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
