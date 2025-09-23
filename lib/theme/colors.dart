import 'package:flutter/material.dart';

/// Centralized color tokens.
/// Replace these hex values with the exact colors from Figma.
class AppColors {
  // Brand
  static const Color primary = Color(0xFF0062FF); // TODO: replace with Figma Primary
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFD9E2FF);
  static const Color onPrimaryContainer = Color(0xFF001A40);

  static const Color secondary = Color(0xFF6B7280); // Neutral/secondary
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFE5E7EB);
  static const Color onSecondaryContainer = Color(0xFF111827);

  static const Color tertiary = Color(0xFF00C2A8);
  static const Color onTertiary = Color(0xFF001A17);
  static const Color tertiaryContainer = Color(0xFF9BF1E3);
  static const Color onTertiaryContainer = Color(0xFF00201C);

  // Error
  static const Color error = Color(0xFFB00020);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFCDADA);
  static const Color onErrorContainer = Color(0xFF410002);

  // Background / Surface (Light)
  static const Color background = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF111827);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF111827);
  static const Color surfaceVariant = Color(0xFFF3F4F6);
  static const Color onSurfaceVariant = Color(0xFF4B5563);
  static const Color outline = Color(0xFFE5E7EB);

  // Background / Surface (Dark)
  static const Color backgroundDark = Color(0xFF0B0F14);
  static const Color onBackgroundDark = Color(0xFFE5E7EB);
  static const Color surfaceDark = Color(0xFF0F141A);
  static const Color onSurfaceDark = Color(0xFFE5E7EB);
  static const Color surfaceVariantDark = Color(0xFF1F2937);
  static const Color onSurfaceVariantDark = Color(0xFF9CA3AF);
  static const Color outlineDark = Color(0xFF374151);
}
