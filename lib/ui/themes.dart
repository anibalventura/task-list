import 'package:task_list/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Themes {
  /*
  * Colors.
  */

  // Light.
  static final Color _lightPrimaryColor = Colors.lightBlue;
  static final Color _lightAccentColor = Colors.lightGreen;
  static const Color _lightBackgroundColor = Colors.white;
  static const Color _lightButtonColor = Colors.white;
  static final Color _lightCardColor = Colors.grey.shade100;
  static final Color _lightPrimaryTextColor = Colors.black;

  // Dark.
  static final Color _darkPrimaryColor = Colors.lightBlue.shade700;
  static final Color _darkAccentColor = Colors.lightGreen.shade700;
  static const Color _darkBackgroundColor = Color(0xFF22252D);
  static const Color _darkButtonColor = Color(0xFF22252D);
  static const Color _darkCardColor = Color(0xFF292D36);
  static const Color _darkPrimaryTextColor = Colors.white;

  /*
  * Text Sizes.
  */

  final double _headlineTextSize1 = isLandscape() ? 44.sp : 40.sp;
  double get headlineTextSize1 => _headlineTextSize1;

  final double _headlineTextSize2 = isLandscape() ? 34.sp : 30.sp;
  double get headlineTextSize2 => _headlineTextSize2;

  final double _bodyTextSize1 = isLandscape() ? 32.sp : 18.sp;
  double get bodyTextSize1 => _bodyTextSize1;

  final double _bodyTextSize2 = isLandscape() ? 26.sp : 16.sp;
  double get bodyTextSize2 => _bodyTextSize2;

  final double _bodyTextSize3 = isLandscape() ? 24.sp : 14.sp;
  double get bodyTextSize3 => _bodyTextSize3;

  final double _iconSize = isLandscape() ? 0.02.sw : 0.045.sw;
  double get iconSize => _iconSize;

  /*
  * Styles.
  */

  static const AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  );

  static const TextStyle _headlineText1 = TextStyle(
    fontWeight: FontWeight.w400,
  );

  static const TextStyle _bodyText1 = TextStyle(
    fontWeight: FontWeight.w700,
  );

  /*
  * Themes.
  */

  // Light.
  static ThemeData lightTheme = ThemeData(
    primaryColor: _lightPrimaryColor,
    accentColor: _lightAccentColor,
    scaffoldBackgroundColor: _lightBackgroundColor,
    appBarTheme: _appBarTheme,
    buttonColor: _lightButtonColor,
    cardColor: _lightCardColor,
    primaryIconTheme: IconThemeData(
      color: _lightPrimaryColor,
    ),
    textTheme: TextTheme(
      headline1: _headlineText1.copyWith(
        color: _lightPrimaryTextColor,
      ),
      bodyText1: _bodyText1.copyWith(
        color: _lightPrimaryTextColor,
      ),
    ),
    fontFamily: GoogleFonts.roboto().fontFamily,
  );

  // Dark.
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: _darkPrimaryColor,
    accentColor: _darkAccentColor,
    scaffoldBackgroundColor: _darkBackgroundColor,
    appBarTheme: _appBarTheme,
    cardColor: _darkCardColor,
    buttonColor: _darkButtonColor,
    primaryIconTheme: IconThemeData(
      color: _darkPrimaryColor,
    ),
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
