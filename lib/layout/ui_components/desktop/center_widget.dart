import 'package:auto_size_text/auto_size_text.dart';
import 'package:comfortex_ai/layout/ui_components/common/img_container.dart';
import 'package:comfortex_ai/layout/ui_components/common/page_builder.dart';
import 'package:comfortex_ai/layout/ui_components/common/title_widget.dart';
import 'package:comfortex_ai/model/Properties_v2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///CenterWidget is a desktop specific widget displayed among the widgets in
///"desktop_screen_1.dart".
class CenterWidget extends StatefulWidget {
  ///Constructor for the CenterWidget.
  const CenterWidget(
    this.properties,
    this.changeShirt,
    this.setDescription, {
    super.key,
  });
  /// Properties carrying selections from the previous screen
  final PropertiesV2 properties;
  /// A workaround for setting the state..
  final void Function(ShirtType) changeShirt;
  /// A workaround for setting the state..
  final void Function(String description) setDescription;
  //TODO(Hash): Smaller arrows for the PageView.
  //TODO(Hash): better spacing the texts.
  @override
  State<CenterWidget> createState() => _CenterWidgetState();
}

class _CenterWidgetState extends State<CenterWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///[changeBackGround] is easily used in setState and thus
  ///to animate the container imgContainer.
  void changeBackGround(ShirtType newType) {
    widget.changeShirt(newType);
  }

  void setDescription(String description) {
    widget.setDescription(description);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleWidget(
                iconPath: 'assets/icons/shirt_2.png',
                title: 'Garment Type',
              ),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Flexible(
                      child: Material(
                        type: MaterialType.button,
                        color: Colors.white,
                        child: ImgContainer(
                          selected:
                              widget.properties.shirtType == ShirtType.polo,
                          child: Image.asset(
                            'assets/icons/polo.png',
                          ),
                          onTap: () {
                            changeBackGround(ShirtType.polo);
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Material(
                        type: MaterialType.button,
                        color: Colors.white,
                        child: ImgContainer(
                          selected:
                              widget.properties.shirtType == ShirtType.t_shirt,
                          child: Image.asset(
                            'assets/icons/t_shirt.png',
                          ),
                          onTap: () {
                            changeBackGround(ShirtType.t_shirt);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Flexible(
                child: TitleWidget(
                  iconPath: 'assets/icons/19.png',
                  title: 'Material',
                ),
              ),
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: widget.properties.shirtType == null
                    ? Center(
                        child: AutoSizeText(
                          'Select the Garment type to display the materials',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      )
                    : //TODO(Hash): i prefer the if statement style
                    // not responsive after returning from the results screen
                    PageBuilder(
                        widget.properties,
                        widget.setDescription,
                        key: ValueKey(
                          widget.properties.shirtType,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
