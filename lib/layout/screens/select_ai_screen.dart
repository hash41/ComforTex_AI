import 'package:comfortex_ai/layout/screens/desktop_screen_1.dart';
import 'package:comfortex_ai/layout/screens/mobile_screen_1.dart';
import 'package:comfortex_ai/layout/screens/screen.dart';
import 'package:comfortex_ai/layout/ui_components/common/top_bar.dart';
import 'package:comfortex_ai/model/ai_version.dart';
import 'package:comfortex_ai/model/properties.dart';
import 'package:comfortex_ai/model/properties_legacy.dart';
import 'package:comfortex_ai/model/properties_new.dart';
import 'package:comfortex_ai/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SelectAiScreen extends StatelessWidget {
  Properties p1 = PropertiesLegacy();
  AiVersionStore aiDecider = AiVersionStore.instance;
  SelectAiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    final orientation = MediaQuery.of(context).orientation;
    double topBarheight;
    if(height < 650) {
      if(orientation == Orientation.portrait) {
        topBarheight = Style.topBarHeightPortrait;
      } else {
        topBarheight = Style.topBarHeightLandscape;
      }
    }
    else if(height > 650 && height < 1200) {
      topBarheight = Style.topBarHeightDesktop;
    }
    else {
      topBarheight = Style.topBarOver1200;
    }
    return SafeArea(
      child: Scaffold(
        appBar: TopBar(
          loggedIn: true,
          height: topBarheight,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select an AI version:',
              style: Style.desktopSubtitle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildMaterialButton(AiVersion.one, PropertiesLegacy(), context),
                const Gap(27),
                buildMaterialButton(AiVersion.two, PropertiesNew(), context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  MaterialButton buildMaterialButton(
      AiVersion ai, Properties properties, BuildContext context) {
    return MaterialButton(
        elevation: 12,
        hoverElevation: 24,
        hoverColor: Colors.black,
        color: Colors.blueAccent,
        height: MediaQuery.sizeOf(context).height > 500 ? 60 : 40,
        minWidth: MediaQuery.sizeOf(context).height > 500 ? 100 : 70,
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
          await Navigator.push(
            context,
            MaterialPageRoute<Screen>(
              builder: (context) {
                return Screen(
                    desktop: DesktopScreen1(properties),
                    mobile: MobileScreen1(properties));
              },
            ),
          );
        },
        child: Text(
          ai.name,
          style: Style.buttonTextDesktop.copyWith(
            color: Colors.white,
          ),
        ));
  }
}
