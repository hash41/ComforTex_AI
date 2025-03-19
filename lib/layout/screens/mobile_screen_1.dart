import 'package:comfortex_ai/layout/components/common/img_container.dart';
import 'package:comfortex_ai/layout/components/common/title_widget.dart';
import 'package:comfortex_ai/layout/components/mobile/downward_arrow.dart';
import 'package:comfortex_ai/layout/components/mobile/top_bar.dart';
import 'package:comfortex_ai/utils/shirt_type.dart';
import 'package:flutter/material.dart';

///MobileScreen1 displays the Mobile version screen1.
class MobileScreen1 extends StatefulWidget {
  ///Constructor for MobileScreen1
  const MobileScreen1({super.key});

  @override
  State<MobileScreen1> createState() => _MobileScreen1State();
}

class _MobileScreen1State extends State<MobileScreen1> {
  String _type = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.portrait) {
            return SafeArea(
              child: Scaffold(
                appBar: TopBar(MediaQuery.of(context).size.height * 0.1),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[const Flexible(
                    child: SizedBox(
                      height: 50,
                      width: 200,
                      child: TitleWidget(
                        iconPath: 'assets/icons/Shirt_2.png',
                        title: 'Garment Type',
                      ),
                    ),
                  ),
                    Flexible(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height:MediaQuery.of(context).size.height * 0.3,
                        child: CustomPaint(
                          // Set the desired width and height of the arrow
                          painter: DownwardArrow(
                              color: Colors.grey.shade800,strokeWidth: 65,),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                      child: Center(
                        child: Text(
                          'Select the type of shirt',
                          style: TextStyle(fontSize: 24, color: Colors.lightBlue),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: ImgContainer(
                            selected: _type == ShirtType.polo.name,
                            child: Image.asset(
                              fit: BoxFit.contain,
                              'assets/icons/polo.png',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: ImgContainer(
                            selected: _type == ShirtType.t_shirt.name,
                            child: Image.asset(
                              fit: BoxFit.scaleDown,
                              'assets/icons/t_shirt.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
