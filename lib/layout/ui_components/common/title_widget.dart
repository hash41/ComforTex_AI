import 'package:comfortex_ai/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

///A widget that is used multiple times so refactored here.
///Its used for the title of the widgets on Desktop screens(screen1).
///It is a ListTile with an icon and a title.
class TitleWidget extends StatelessWidget {
  ///Constructor for the TitleWidget.
  const TitleWidget({
    String? iconPath,
    required String title,
    bool isLandscape = false,
    bool isMobile = false,
    bool center = true,
    super.key,
  }):  _title = title,
        _iconPath = iconPath,
        _isLandscape = isMobile ? isLandscape : false,
        _isMobile = isMobile,
        _center = center;

  final String? _iconPath;
  final String _title;
  final bool _isLandscape;
  final bool _isMobile;
  final bool _center;

  @override
  Widget build(BuildContext context) {
    if (_isLandscape) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(_iconPath!= null)  RotatedBox(
            quarterTurns: 4,
            child: Image.asset(
              _iconPath,
              fit: BoxFit.contain,
              width: 36,
              height: 36,
            ),
          ),
          Flexible(
            child: RotatedBox(
              quarterTurns: 4,
              child: Text(
                _title,
                overflow: TextOverflow.clip,
                maxLines: 2,
                style: GoogleFonts.roboto(
    textStyle: Style.mobileTitle,
    ),
              ),
            ),
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: _center? MainAxisAlignment.center: MainAxisAlignment.start,
      children: [
        if(_iconPath != null)
          ...[Image.asset(
            _iconPath,
            fit: BoxFit.scaleDown,
            width: _isMobile ? 36:48,
            height: _isMobile ? 36:48,
          ),
          const Gap (
            4,
          ),],
        Flexible(
          child: Text(
            _title,
            style:
            GoogleFonts.roboto(
              textStyle:  _isMobile ? Style.mobileTitle.copyWith(height: 0) : Style.desktopTitle,
            ),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
