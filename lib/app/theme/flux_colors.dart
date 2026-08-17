// flux_colors.dart
// Color scheme derived directly from Flux web app's CSS variables
// (src/index.css) so the Flutter app stays visually consistent
// with the React/Tailwind web app.

import 'package:flutter/material.dart';

class FluxColors {
  // ---------- LIGHT MODE ----------
  static const lightBackground = Color(0xFFF6F7F9);
  static const lightForeground = Color(0xFF131720);
  static const lightCard = Color(0xFFFFFFFF);
  static const lightPrimary = Color(0xFF4251F0); // brand indigo/blue
  static const lightSecondary = Color(0xFFEAECF0);
  static const lightSecondaryForeground = Color(0xFF262F40);
  static const lightMuted = Color(0xFFEAECF0);
  static const lightMutedForeground = Color(0xFF737B8C);
  static const lightAccent = Color(0xFF4251F0); // same as primary in web app
  static const lightDestructive = Color(0xFFEF4444);
  static const lightBorder = Color(0xFFDCDFE5);

  // ---------- DARK MODE ----------
  // (web app defaults to dark mode — see theme-store.ts: darkMode: true)
  static const darkBackground = Color(0xFF14171F);
  static const darkForeground = Color(0xFFE8EAEE);
  static const darkCard = Color(0xFF1D212A);
  static const darkPrimary = Color(0xFF5A67F2);
  static const darkSecondary = Color(0xFF272B35);
  static const darkSecondaryForeground = Color(0xFFC4C9D4);
  static const darkMuted = Color(0xFF272B35);
  static const darkMutedForeground = Color(0xFF818898);
  static const darkAccent = Color(0xFF5A67F2);
  static const darkDestructive = Color(0xFF7F1D1D);
  static const darkBorder = Color(0xFF2B2F3B);
}

final ColorScheme fluxLightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: FluxColors.lightPrimary,
  onPrimary: Colors.white,
  secondary: FluxColors.lightSecondary,
  onSecondary: FluxColors.lightSecondaryForeground,
  error: FluxColors.lightDestructive,
  onError: Colors.white,
  surface: FluxColors.lightCard,
  onSurface: FluxColors.lightForeground,
  surfaceContainerHighest: FluxColors.lightMuted,
  onSurfaceVariant: FluxColors.lightMutedForeground,
  outline: FluxColors.lightBorder,
  tertiary: FluxColors.lightAccent,
  onTertiary: Colors.white,
);

final ColorScheme fluxDarkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: FluxColors.darkPrimary,
  onPrimary: Colors.white,
  secondary: FluxColors.darkSecondary,
  onSecondary: FluxColors.darkSecondaryForeground,
  error: FluxColors.darkDestructive,
  onError: Colors.white,
  surface: FluxColors.darkCard,
  onSurface: FluxColors.darkForeground,
  surfaceContainerHighest: FluxColors.darkMuted,
  onSurfaceVariant: FluxColors.darkMutedForeground,
  outline: FluxColors.darkBorder,
  tertiary: FluxColors.darkAccent,
  onTertiary: Colors.white,
);

final ThemeData fluxLightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: fluxLightColorScheme,
  scaffoldBackgroundColor: FluxColors.lightBackground,
  fontFamily: 'Inter', // matches web app's font-sans (Inter)
  cardColor: FluxColors.lightCard,
  dividerColor: FluxColors.lightBorder,
);

final ThemeData fluxDarkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: fluxDarkColorScheme,
  scaffoldBackgroundColor: FluxColors.darkBackground,
  fontFamily: 'Inter',
  cardColor: FluxColors.darkCard,
  dividerColor: FluxColors.darkBorder,
);

