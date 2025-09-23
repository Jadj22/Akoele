import 'package:flutter/material.dart';

/// Centralized color tokens.
/// Hex values extracted from Figma file (shared link):
/// - Primary ramp (couleur primaire): #CC6600 (dark), #FF7F00 (base), #FFA540 (light)
/// - Secondary ramp (couleur secondaire): #0077CC (blue), #FFD700 (yellow), #FFF9E6 (cream)
/// - Status (couleur statut): success #22BB33, error #BB2124, warning #F0AD4E
class AppColors {
  // Brand
  static const Color primary = Color(0xFFFF7F00); // Figma: Rectangle base (couleur primaire)
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFFFA540); // lighter swatch from Figma primary
  static const Color onPrimaryContainer = Color(0xFF1F1200);

  // Secondary ramp seen in Figma (blue/yellow/cream). We use blue as secondary base.
  static const Color secondary = Color(0xFF0077CC);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFFFF9E6); // cream swatch from Figma
  static const Color onSecondaryContainer = Color(0xFF111827);

  // Tertiary mapped to success green from status ramp
  static const Color tertiary = Color(0xFF22BB33);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFE6F7EA); // light green container
  static const Color onTertiaryContainer = Color(0xFF0E3A14);

  // Error
  static const Color error = Color(0xFFBB2124); // Figma status red
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFAD7D7);
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
