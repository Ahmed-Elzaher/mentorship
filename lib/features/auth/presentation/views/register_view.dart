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

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().register(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
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
          if (state is RegisterSuccess) {
            AppSnackBar.showSuccess(context, l10n.registerSuccess);
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.verifyEmail,
              arguments: state.email,
            );
          } else if (state is AuthError) {
            AppSnackBar.showError(context, state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.createAccount,
                        style: AppTextStyles.headingLarge(),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        l10n.signUpSubtitle,
                        style: AppTextStyles.bodyMedium(),
                      ),
                      SizedBox(height: 28.h),

                      // First & Last Name
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _firstNameController,
                              labelText: l10n.firstName,
                              hintText: 'John',
                              validator: (val) => AppValidators.validateRequired(
                                value: val,
                                requiredMessage: l10n.fieldRequired,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: CustomTextField(
                              controller: _lastNameController,
                              labelText: l10n.lastName,
                              hintText: 'Doe',
                              validator: (val) => AppValidators.validateRequired(
                                value: val,
                                requiredMessage: l10n.fieldRequired,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // Email
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
                      SizedBox(height: 16.h),

                      // Password
                      CustomTextField(
                        controller: _passwordController,
                        labelText: l10n.password,
                        hintText: l10n.createPassword,
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
                      SizedBox(height: 32.h),

                      // Register Button
                      CustomButton(
                        text: l10n.register,
                        isLoading: isLoading,
                        icon: const Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.textDark,
                          size: 20,
                        ),
                        onPressed: () => _onRegisterPressed(context),
                      ),
                      SizedBox(height: 24.h),

                      // Back to login
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            l10n.alreadyHaveAccount,
                            style: AppTextStyles.bodyMedium(),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              l10n.signIn,
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
