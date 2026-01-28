import 'dart:async';

import 'package:comfortex_ai/layout/screens/desktop_screen_1.dart';
import 'package:comfortex_ai/layout/screens/mobile_screen_1.dart';
import 'package:comfortex_ai/layout/screens/screen.dart';
import 'package:comfortex_ai/layout/ui_components/common/top_bar.dart';
import 'package:comfortex_ai/model/Properties_v2.dart';
import 'package:comfortex_ai/model/ai_version.dart';
import 'package:comfortex_ai/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SelectAiScreen extends StatelessWidget {
  PropertiesV2 properties = PropertiesV2();
  ValueNotifier<String> message = ValueNotifier<String>('');
  AiVersionStore aiDecider = AiVersionStore.instance;
  SelectAiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;//Can be final, because the
    //build method will run again after change of screensize..
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
            const Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildMaterialButton(AiVersion.one, context,),
                const Gap(27),
                buildMaterialButton(AiVersion.two, context,),
                const Gap(27),
                buildMaterialButton(AiVersion.twoDynamicPredictions, context,),

              ],
            ),
            const Gap(12),
        ValueListenableBuilder<String>(
          valueListenable: message,
          builder: (_, value, __) => Text(value,
            style: Style.bodyTextDesktop.copyWith(
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
        )

          ],
        ),
      ),
    );
  }

  MaterialButton buildMaterialButton(
      AiVersion ai, BuildContext context) {
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
          if(ai == AiVersion.one)
            {
              generatedProperties = properties.generatePropertiesV1();
            }
          else if (ai == AiVersion.two)
          {
            generatedProperties = properties.generatePropertiesV2();
          }
          else
            {
              generatedProperties = await properties.generatePropertiesDynamic();
            }
          if(!generatedProperties)
            {
              message.value =
                'Couldn\'t generate properties, try a different version';
            }
          else
          {
          Navigator.push(
            context,
            MaterialPageRoute<Screen>(
              builder: (context) {
                return Screen(
                    desktop: DesktopScreen1(properties),
                    mobile: MobileScreen1(properties));
              },
            ),
          );
          }
        },
        child: Text(
          ai == AiVersion.twoDynamicPredictions ? 'two+' : ai.name,
          style: Style.buttonTextDesktop.copyWith(
            color: Colors.white,
          ),
        ));
  }
}
