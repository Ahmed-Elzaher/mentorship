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

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            AppSnackBar.showSuccess(context, l10n.loginSuccess);
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          } else if (state is AuthError) {
            AppSnackBar.showError(context, state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10.h),
                      // Logo Badge from Design
                      Center(
                        child: Container(
                          width: 72.w,
                          height: 72.h,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(22.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.35),
                                blurRadius: 18,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22.r),
                            child: Image.asset(
                              'assets/icons/app_logo.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.flash_on_rounded,
                                size: 36,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Title & Subtitle with AppTextStyles
                      Text(
                        l10n.letsSignIn,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headingLarge(),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        l10n.welcomeBack,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium(),
                      ),
                      SizedBox(height: 36.h),

                      // Email Field
                      CustomTextField(
                        controller: _emailController,
                        labelText: l10n.emailAddress,
                        hintText: l10n.enterEmail,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(
                          Icons.mail_outline_rounded,
                          color: AppColors.textMuted,
                        ),
                        validator: (value) => AppValidators.validateEmail(
                          value: value,
                          requiredMessage: l10n.emailRequired,
                          invalidMessage: l10n.invalidEmail,
                        ),
                      ),
                      SizedBox(height: 18.h),

                      // Password Field
                      CustomTextField(
                        controller: _passwordController,
                        labelText: l10n.password,
                        hintText: l10n.enterPassword,
                        obscureText: _obscurePassword,
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: AppColors.textMuted,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.textMuted,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        validator: (value) => AppValidators.validatePassword(
                          value: value,
                          requiredMessage: l10n.passwordRequired,
                          minLengthMessage: l10n.passwordTooShort,
                        ),
                      ),
                      SizedBox(height: 28.h),

                      // Sign In Button
                      CustomButton(
                        text: l10n.signIn,
                        isLoading: isLoading,
                        icon: const Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.textDark,
                          size: 20,
                        ),
                        onPressed: () => _onLoginPressed(context),
                      ),
                      SizedBox(height: 24.h),

                      // Register Navigation Link
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            l10n.dontHaveAccount,
                            style: AppTextStyles.bodyMedium(),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.register);
                            },
                            child: Text(
                              l10n.signUp,
                              style: AppTextStyles.bodyLarge(
                                color: AppColors.textDark,
                              ).copyWith(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
