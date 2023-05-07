import 'package:flutter/material.dart';

class AppThemes {
  static const _fontFamily = 'Mont';

  static final light = ThemeData(
    fontFamily: _fontFamily,
    scaffoldBackgroundColor: const Color(0xffD6DAF0),
    colorScheme: const ColorScheme.dark().copyWith(
      background: const Color(0xffE9E4F9),
      onBackground: const Color(0xff676767),
      primary: const Color(0xffBFC1E9),
      secondary: Colors.white,
      onSecondary: const Color(0xff676767),
    ),
    drawerTheme: const DrawerThemeData(
      scrimColor: Color.fromRGBO(202, 208, 232, 0.32),
    ),
  );

  static final dark = ThemeData(
    fontFamily: _fontFamily,
    colorScheme: const ColorScheme.dark().copyWith(
      background: const Color(0xff2f1a75),
      onBackground: Colors.white,
      primary: const Color(0xff20235e),
      secondary: Colors.white,
      onSecondary: const Color(0xff676767),
    ),
    scaffoldBackgroundColor: const Color(0xff242e63),
  );
}
