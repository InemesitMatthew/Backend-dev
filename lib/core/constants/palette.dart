import 'package:flutter/cupertino.dart';

class Palette {
  const Palette();
  // Brand and surfaces.
  static const Color background = Color(0xFFF7F7FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF000130);
  static const Color primaryMuted = Color(0xFF7C7C92);
  static const Color border = Color(0xFFE6E6EE);
  static const Color border2 = Color(0xFF363636);
  static const Color black = Color(0xFF000000);
  static const Color black2 = Color(0xFF1E1E1E);
  // Text colors.
  static const Color textPrimary = Color(0xFF121212);
  static const Color textSecondary = Color(0xFF6F6F7B);
  // Status colors.
  static const Color success = Color(0xFF1E8E3E);
  static const Color warning = Color(0xFFFFC704);
  static const Color overlay = Color(0x99000000);
  static const Color baseError = Color(0xFFD50202);
  // Semantic aliases for shared widgets.
  static const Color basePrimary = primary;
  static const Color text100 = textPrimary;
  static const Color text300 = textSecondary;
  static const Color textBody = textSecondary;
  static const Color fillColor = surface;
  static const Color linkBlue = primary;
}
