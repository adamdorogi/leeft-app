import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

/// A collection of themes.
abstract final class Themes {
  /// The theme for the light [ThemeMode].
  static final lightTheme = ThemeData(
    textTheme: GoogleFonts.interTextTheme(),
  );

  /// The theme for the dark [ThemeMode].
  static final darkTheme = ThemeData(
    brightness: .dark,
    textTheme: GoogleFonts.interTextTheme(),
  );
}
