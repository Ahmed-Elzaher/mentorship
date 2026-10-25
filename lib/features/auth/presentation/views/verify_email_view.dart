import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentorship/core/localization/l10n_extension.dart';
import 'package:mentorship/core/routes/app_routes.dart';
import 'package:mentorship/core/theme/app_colors.dart';
import 'package:mentorship/core/theme/app_text_styles.dart';
import 'package:mentorship/core/utils/app_snackbar.dart';
import 'package:mentorship/core/utils/app_validators.dart';
import 'package:mentorship/core/widgets/custom_button.dart';
import 'package:mentorship/core/widgets/custom_text_field.dart';
import 'package:mentorship/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mentorship/features/auth/presentation/cubit/auth_state.dart';

class VerifyEmailView extends StatefulWidget {
  final String email;

  const VerifyEmailView({super.key, required this.email});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _onVerifyPressed(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().verifyEmail(
            email: widget.email,
            otp: _otpController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is VerifyEmailSuccess) {
            AppSnackBar.showSuccess(context, l10n.verifySuccess);
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (route) => false,
            );
          } else if (state is AuthError) {
            AppSnackBar.showError(context, state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10.h),
                    Center(
                      child: Container(
                        width: 72.w,
                        height: 72.h,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.35),
                              blurRadius: 18,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.mark_email_read_outlined,
                          size: 36,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Text(
                      l10n.otpVerification,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headingLarge(),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      l10n.otpSentTo(widget.email),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium(),
                    ),
                    SizedBox(height: 36.h),

                    // OTP field
                    CustomTextField(
                      controller: _otpController,
                      labelText: l10n.verificationCode,
                      hintText: l10n.enterOtp,
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(
                        Icons.pin_outlined,
                        color: AppColors.textMuted,
                      ),
                      validator: (value) => AppValidators.validateRequired(
                        value: value,
                        requiredMessage: l10n.otpRequired,
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Verify button
                    CustomButton(
                      text: l10n.verifyCode,
                      isLoading: isLoading,
                      icon: const Icon(
                        Icons.check_circle_outline,
                        color: AppColors.textDark,
                        size: 20,
                      ),
                      onPressed: () => _onVerifyPressed(context),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
