import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_pallete.dart';

class CustomThemeData {
  static ThemeData lightTheme() {
    return ThemeData(
        primaryTextTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.indigo,
        appBarTheme: const AppBarTheme(
            backgroundColor: ColorPalette.primaryColor,
            foregroundColor: ColorPalette.brighterTextColor));
  }
}
