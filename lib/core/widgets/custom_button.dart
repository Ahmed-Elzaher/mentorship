import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentorship/core/theme/app_colors.dart';
import 'package:mentorship/core/theme/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.text,
    this.child,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.padding,
    this.borderRadius,
    this.width,
    this.height,
    this.alignment,
    this.elevation,
    this.shape,
    this.icon,
    this.enabled = true,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final double? elevation;
  final OutlinedBorder? shape;
  final Widget? icon;
  final bool enabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final effectiveBg = backgroundColor ?? AppColors.primary;
    final effectiveTextColor = textColor ??
        (effectiveBg == AppColors.primary ? AppColors.textDark : Colors.white);

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 54.h,
      child: ElevatedButton(
        onPressed: (isLoading || !enabled) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBg,
          elevation: elevation ?? 0,
          alignment: alignment,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
          shape: shape ??
              RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(16.r),
              ),
        ),
        child: isLoading
            ? SizedBox(
                height: 22.h,
                width: 22.w,
                child: CircularProgressIndicator(
                  color: effectiveTextColor,
                  strokeWidth: 2.5,
                ),
              )
            : child ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      text ?? '',
                      style: AppTextStyles.button(color: effectiveTextColor),
                    ),
                    if (icon != null) ...[
                      SizedBox(width: 8.w),
                      icon!,
                    ],
                  ],
                ),
      ),
    );
  }
}
