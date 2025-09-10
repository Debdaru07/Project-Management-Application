import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_palette.dart' as palette;

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: palette.AppPalette.resolutionBlue,
    scaffoldBackgroundColor: palette.AppPalette.magnolia,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        color: palette.AppPalette.raisinBlack,
      ),
      displayMedium: GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: palette.AppPalette.tropicalIndigo,
      ),
      displaySmall: GoogleFonts.openSans(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: palette.AppPalette.periwinkle,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: palette.AppPalette.resolutionBlue,
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: palette.AppPalette.raisinBlack,
      ),
      bodyMedium: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: palette.AppPalette.tropicalIndigo,
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: palette.AppPalette.magnolia,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: palette.AppPalette.raisinBlack,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: palette.AppPalette.magnolia,
        ),
        backgroundColor: palette.AppPalette.resolutionBlue,
        foregroundColor: palette.AppPalette.magnolia,
      ),
    ),
  );
}
