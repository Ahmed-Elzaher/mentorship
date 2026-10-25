import 'package:flutter/material.dart';

abstract class AppColors {
  // الألوان الأساسية المستوحاة من تصميم المتجر
  static const Color primary = Color(0xFFF9F506); // Volt Lime / Neon Yellow
  static const Color primaryDark = Color(0xFFE6E205);
  static const Color secondary = Color(0xFF1E1E1E);
  static const Color background = Color(0xFFF8F8F5);
  static const Color surface = Colors.white;

  // ألوان النصوص
  static const Color textDark = Color(0xFF0F172A); // Slate 900
  static const Color textMuted = Color(0xFF64748B); // Slate 500

  // الحواف والحالات
  static const Color border = Color(0xFFE2E8F0);
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF22C55E);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFFF1F5F9);
}
