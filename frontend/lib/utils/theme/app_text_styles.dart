import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_palette.dart' as palette;

class AppTextStyles {
  static TextStyle get displayLarge => GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    color: palette.AppPalette.raisinBlack,
  );

  static TextStyle get displayMedium => GoogleFonts.roboto(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: palette.AppPalette.tropicalIndigo,
  );

  static TextStyle get displaySmall => GoogleFonts.openSans(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: palette.AppPalette.periwinkle,
  );

  static TextStyle get headlineMedium => GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: palette.AppPalette.resolutionBlue,
  );

  static TextStyle get bodyLarge => GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: palette.AppPalette.raisinBlack,
  );

  static TextStyle get bodyMedium => GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: palette.AppPalette.tropicalIndigo,
  );

  static TextStyle get labelLarge => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: palette.AppPalette.magnolia,
  );
}
