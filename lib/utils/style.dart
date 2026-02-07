import 'package:flutter/material.dart';


/// A class to store the styles used in the app.
class Style {

  static const _title =   TextStyle(
    color: Colors.lightBlue,
    overflow: TextOverflow.visible,
  );
  static const _subtitle = TextStyle(
    color: Colors.black,
  );
  static const _bodyText = TextStyle(
    color: Colors.black,
  );
  static const _buttonText = TextStyle(
    fontWeight: FontWeight.bold,
  );
  static const _captionText = TextStyle(
    color: Color(0xFF7f7d7c),
  );

  static const _resultText = TextStyle(
    color: Color(0xFF7f7d7c),
  );

  static const _topBarHeightDesktop = 67.0;
  static const _topBarSizeOver1200 = 75.0;
  static const _topBarHPortrait = 61.5;
  static const _topBarHMobileLandscape = 50.0;
  /// getter of the mobileTitle [TextStyle]
  static TextStyle get mobileTitle => _title.copyWith(
      fontSize:  24, fontWeight: FontWeight.w400,
    //TODO(Hash): I prefer red accent
      );
  /// getter of the desktopTitle [TextStyle]
static TextStyle get desktopTitle => _title.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.visible,
      );
  /// getter of the mobileSubtitle [TextStyle]
  static TextStyle get mobileSubtitle => _subtitle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );
  /// getter of the desktopSubtitle [TextStyle]
  static TextStyle get desktopSubtitle => _subtitle.copyWith(
        fontSize: 21,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.visible,
      );
  /// getter [TextStyle]
  static TextStyle get bodyTextMobile => _bodyText.copyWith(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  );
  /// getter [TextStyle]
  static TextStyle get bodyTextDesktop => _bodyText.copyWith(
  fontSize: 19,
  fontWeight: FontWeight.w400,
  );
  /// getter [TextStyle]
  static TextStyle get buttonTextMobile => _buttonText.copyWith(
        fontSize: 14,
    overflow: TextOverflow.visible,
      );
  /// getter [TextStyle]
  static TextStyle get buttonTextDesktop => _buttonText.copyWith(
        fontSize: 16,
      );
  /// getter [TextStyle]
  ///Consider a caption mobile of size 12..
  static TextStyle get captionTextMobile => _captionText.copyWith(
        fontSize: 11,
      );
  /// getter [TextStyle]
  static TextStyle get captionTextDesktop => _captionText.copyWith(
        fontSize: 14,
      );
  /// getter [TextStyle]
  static TextStyle get resultTextDesktop => _resultText.copyWith(
        fontSize: 19,
        fontWeight: FontWeight.w400,
      );
  /// getter [TextStyle]
  static TextStyle get resultTextMobile => _resultText.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  /// getter [double]
  static double get topBarHeightPortrait =>
      _topBarHPortrait;
  /// getter [double]
  static double get topBarHeightLandscape =>
      _topBarHMobileLandscape;
  /// getter [double]
  static double get topBarHeightDesktop =>
      _topBarHeightDesktop;
  /// getter [double]
  static double get topBarOver1200 =>
      _topBarSizeOver1200;
}
