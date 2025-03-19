import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

///A widget that is used multiple times so refactored here.
///Its used for the title of the widgets on Desktop screens(screen1).
///It is a ListTile with an icon and a title.
class TitleWidget extends StatelessWidget {
  ///Constructor for the TitleWidget.
  const TitleWidget({
    required String iconPath, required String title, super.key,
  }) : _title = title, _iconPath = iconPath;


  final String _iconPath;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Image.asset(
        _iconPath,
        fit: BoxFit.contain,
        width: 48,
        height: 48,
      ),
      AutoSizeText(
        _title,
        overflow: TextOverflow.clip,
        maxLines: 2,
        style: const TextStyle(fontSize: 24, color: Colors.lightBlue),
      ),
      ],);
  }
}
