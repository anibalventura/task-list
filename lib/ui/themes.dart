import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData theme(BuildContext context) => Theme.of(context);
bool isLandscape() => ScreenUtil().orientation == Orientation.landscape;

class Themes {
  /*
  * Colors.
  */
  static const Color _iconColor = Colors.white;
  static const Color _secondaryTextColor = Colors.white;

  // Light.
  static const Color _lightPrimaryColor = Color(0xFF4B5B7B);
  static const Color _lightAccentColor = Color(0xFF7FA8FB);
  static const Color _lightBackgroundColor = Colors.white;
  static const Color _lightPrimaryTextColor = Color(0xFF313A4E);
  static const Color _lightDeleteColor = Color(0xFFFA6D6D);
  static const Color _lightEditColor = Color(0xFFFEC54D);

  // Dark.
  static const Color _darkPrimaryColor = Color(0xFF3C4861);
  static const Color _darkAccentColor = Color(0xFF5D7BBA);
  static const Color _darkBackgroundColor = Color(0xFF22252D);
  static const Color _darkPrimaryTextColor = Colors.white;
  static const Color _darkDeleteColor = Color(0xFFC24747);
  static const Color _darkEditColor = Color(0xFFD4A33A);

  /*
  * Text Sizes.
  */

  final double _headlineTextSize = isLandscape() ? 32.sp : 16.sp;
  double get headlineTextSize => _headlineTextSize;

  final double _bodyTextSize = isLandscape() ? 26.sp : 14.sp;
  double get bodyTextSize => _bodyTextSize;

  /*
  * Styles.
  */

  // static const AppBarTheme _appBarTheme = AppBarTheme(
  //   backgroundColor: Colors.transparent,
  //   elevation: 0,
  // );

  static const TextStyle _headlineText1 = TextStyle(
    fontWeight: FontWeight.w600,
  );

  static const TextStyle _bodyText1 = TextStyle(
    fontWeight: FontWeight.w500,
  );

  static const TextStyle _bodyText2 = TextStyle(
    fontWeight: FontWeight.w700,
  );

  /*
  * Themes.
  */

  // Light.
  static ThemeData lightTheme = ThemeData(
    primaryColor: _lightPrimaryColor,
    accentColor: _lightAccentColor,
    backgroundColor: _lightBackgroundColor,
    errorColor: _lightDeleteColor,
    highlightColor: _lightEditColor,
    iconTheme: const IconThemeData(
      color: _iconColor,
    ),
    textTheme: TextTheme(
      headline1: _headlineText1.copyWith(
        color: _lightPrimaryTextColor,
      ),
      headline2: _headlineText1.copyWith(
        color: _secondaryTextColor,
      ),
      bodyText1: _bodyText1.copyWith(
        color: _lightPrimaryTextColor,
      ),
      bodyText2: _bodyText2.copyWith(
        color: _secondaryTextColor,
      ),
    ),
    fontFamily: GoogleFonts.roboto().fontFamily,
  );

  // Dark.
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: _darkPrimaryColor,
    accentColor: _darkAccentColor,
    backgroundColor: _darkBackgroundColor,
    errorColor: _darkDeleteColor,
    highlightColor: _darkEditColor,
    textTheme: TextTheme(
      headline1: _headlineText1.copyWith(
        color: _darkPrimaryTextColor,
      ),
      bodyText1: _bodyText1.copyWith(
        color: _darkPrimaryTextColor,
      ),
    ),
  );
}
