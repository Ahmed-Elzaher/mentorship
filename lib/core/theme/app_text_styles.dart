import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentorship/core/theme/app_colors.dart';

abstract class AppTextStyles {
  // Headings
  static TextStyle headingLarge({Color color = AppColors.textDark}) =>
      GoogleFonts.cairo(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: -0.5,
      );

  static TextStyle headingMedium({Color color = AppColors.textDark}) =>
      GoogleFonts.cairo(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: color,
      );

  static TextStyle headingSmall({Color color = AppColors.textDark}) =>
      GoogleFonts.cairo(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: color,
      );

  // Titles
  static TextStyle titleMedium({Color color = AppColors.textDark}) =>
      GoogleFonts.cairo(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle titleSmall({Color color = AppColors.textDark}) =>
      GoogleFonts.cairo(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: color,
      );

  // Body
  static TextStyle bodyLarge({Color color = AppColors.textDark}) =>
      GoogleFonts.cairo(
        fontSize: 15.sp,
        fontWeight: FontWeight.normal,
        color: color,
      );

  static TextStyle bodyMedium({Color color = AppColors.textMuted}) =>
      GoogleFonts.cairo(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: color,
        height: 1.5,
      );

  static TextStyle bodySmall({Color color = AppColors.textMuted}) =>
      GoogleFonts.cairo(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: color,
      );

  // Button & Badges
  static TextStyle button({Color color = AppColors.textDark}) =>
      GoogleFonts.cairo(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: color,
      );

  static TextStyle caption({Color color = AppColors.textMuted}) =>
      GoogleFonts.cairo(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: color,
      );
}
