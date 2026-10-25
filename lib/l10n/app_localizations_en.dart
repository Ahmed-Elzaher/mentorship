// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Lumina Store';

  @override
  String get letsSignIn => 'Let\'s Sign You In';

  @override
  String get welcomeBack => 'Welcome back, you\'ve been missed!';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get password => 'Password';

  @override
  String get enterPassword => 'Enter your password';

  @override
  String get createPassword => 'Create a password';

  @override
  String get signIn => 'Sign In';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get signUp => 'Sign Up';

  @override
  String get createAccount => 'Create Account';

  @override
  String get signUpSubtitle =>
      'Sign up to get started and explore great products!';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get register => 'Register';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get otpVerification => 'OTP Verification';

  @override
  String otpSentTo(String email) {
    return 'We have sent a 6-digit verification code to:\n$email';
  }

  @override
  String get verificationCode => 'Verification Code (OTP)';

  @override
  String get enterOtp => 'Enter OTP';

  @override
  String get verifyCode => 'Verify Code';

  @override
  String get loginSuccess => 'Logged in successfully! Welcome.';

  @override
  String get registerSuccess =>
      'Account created successfully! Please verify your email.';

  @override
  String get verifySuccess =>
      'Account verified successfully! You can sign in now.';

  @override
  String get sessionRefreshed => 'Session refreshed successfully!';

  @override
  String sessionRefreshFailed(String message) {
    return 'Failed to refresh session: $message';
  }

  @override
  String get emailRequired => 'Email is required';

  @override
  String get invalidEmail => 'Invalid email format';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get otpRequired => 'OTP code is required';

  @override
  String get searchHint => 'Search streetwear, accessories...';

  @override
  String get categories => 'Categories';

  @override
  String get all => 'All';

  @override
  String get products => 'Products';

  @override
  String itemsCount(int count) {
    return '$count items';
  }

  @override
  String get noProductsFound => 'No products match your search';

  @override
  String get errorLoadingData => 'Error loading data';

  @override
  String get retry => 'Retry';

  @override
  String get productDetails => 'Product Details';

  @override
  String inStock(int count) {
    return 'In Stock ($count)';
  }

  @override
  String get outOfStock => 'Out of Stock';

  @override
  String reviewsCount(int count) {
    return '$count reviews';
  }

  @override
  String get description => 'Description';

  @override
  String get noDescription => 'No description provided for this item.';

  @override
  String get addToCart => 'Add to Cart';

  @override
  String addedToCart(String name) {
    return 'Added $name to cart!';
  }

  @override
  String get deleteProduct => 'Delete Product';

  @override
  String get confirmDeleteTitle => 'Confirm Deletion';

  @override
  String confirmDeleteMessage(String name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get deleteSuccess => 'Product deleted successfully!';

  @override
  String get logout => 'Logout';
}
