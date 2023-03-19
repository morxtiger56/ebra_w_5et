import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFAE3203),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFFFDBD1),
  onPrimaryContainer: Color(0xFF3A0A00),
  secondary: Color(0xFF77574D),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFFFDBD1),
  onSecondaryContainer: Color(0xFF2C150F),
  tertiary: Color(0xFF006C4F),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFF85F8CB),
  onTertiaryContainer: Color(0xFF002116),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFFFFFF),
  onBackground: Color(0xFF3E0021),
  surface: Color(0xFFFFFBFF),
  onSurface: Color(0xFF3E0021),
  surfaceVariant: Color(0xFFF5DED7),
  onSurfaceVariant: Color(0xFF53433F),
  outline: Color(0xFF85736E),
  onInverseSurface: Color(0xFFFFECF0),
  inverseSurface: Color(0xFF5D1137),
  inversePrimary: Color(0xFFFFB59F),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFAE3203),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFFFB59F),
  onPrimary: Color(0xFF5F1600),
  primaryContainer: Color(0xFF862300),
  onPrimaryContainer: Color(0xFFFFDBD1),
  secondary: Color(0xFFE7BDB2),
  onSecondary: Color(0xFF442A22),
  secondaryContainer: Color(0xFF5D4037),
  onSecondaryContainer: Color(0xFFFFDBD1),
  tertiary: Color(0xFF68DBB0),
  onTertiary: Color(0xFF003828),
  tertiaryContainer: Color(0xFF00513B),
  onTertiaryContainer: Color(0xFF85F8CB),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF3E0021),
  onBackground: Color(0xFFFFD9E4),
  surface: Color(0xFF3E0021),
  onSurface: Color(0xFFFFD9E4),
  surfaceVariant: Color(0xFF53433F),
  onSurfaceVariant: Color(0xFFD8C2BC),
  outline: Color(0xFFA08C87),
  onInverseSurface: Color(0xFF3E0021),
  inverseSurface: Color(0xFFFFD9E4),
  inversePrimary: Color(0xFFAE3203),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFFFB59F),
);

ThemeData lightThemeData = ThemeData(
  colorScheme: lightColorScheme,
  useMaterial3: true,
  textTheme: const TextTheme(
    displaySmall: TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      color: Colors.grey,
      fontSize: 14,
    ),
  ),
  fontFamily: GoogleFonts.poppins().fontFamily,
);
ThemeData darkThemeData = ThemeData(
  colorScheme: darkColorScheme,
  useMaterial3: true,
  textTheme: const TextTheme(
    displaySmall: TextStyle(
      fontSize: 16,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 14,
    ),
  ),
  fontFamily: GoogleFonts.poppins().fontFamily,
);
