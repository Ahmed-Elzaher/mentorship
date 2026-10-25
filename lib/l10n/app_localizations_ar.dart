// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'متجر لومينا';

  @override
  String get letsSignIn => 'تسجيل الدخول';

  @override
  String get welcomeBack => 'مرحباً بعودتك، لقد افتقدناك!';

  @override
  String get emailAddress => 'البريد الإلكتروني';

  @override
  String get enterEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get enterPassword => 'أدخل كلمة المرور';

  @override
  String get createPassword => 'أنشئ كلمة المرور';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟ ';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get createAccount => 'إنشاء حساب جديد';

  @override
  String get signUpSubtitle => 'سجل الآن للبدء واستكشاف أفضل المنتجات!';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get register => 'تسجيل';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟ ';

  @override
  String get otpVerification => 'تأكيد رمز التحقق';

  @override
  String otpSentTo(String email) {
    return 'لقد أرسلنا رمز تحقق مكوّن من 6 أرقام إلى:\n$email';
  }

  @override
  String get verificationCode => 'رمز التحقق (OTP)';

  @override
  String get enterOtp => 'أدخل الرمز';

  @override
  String get verifyCode => 'تأكيد الرمز';

  @override
  String get loginSuccess => 'تم تسجيل الدخول بنجاح! مرحباً بك.';

  @override
  String get registerSuccess => 'تم إنشاء الحساب بنجاح! يرجى إدخال رمز التحقق.';

  @override
  String get verifySuccess => 'تم تفعيل الحساب بنجاح! يمكنك تسجيل الدخول الآن.';

  @override
  String get sessionRefreshed => 'تم تجديد الجلسة بنجاح!';

  @override
  String sessionRefreshFailed(String message) {
    return 'فشل تجديد الجلسة: $message';
  }

  @override
  String get emailRequired => 'يرجى إدخال البريد الإلكتروني';

  @override
  String get invalidEmail => 'صيغة البريد الإلكتروني غير صحيحة';

  @override
  String get passwordRequired => 'يرجى إدخال كلمة المرور';

  @override
  String get passwordTooShort => 'كلمة المرور يجب ألا تقل عن 6 أحرف';

  @override
  String get fieldRequired => 'هذا الحقل مطلوب';

  @override
  String get otpRequired => 'يرجى إدخال رمز التحقق';

  @override
  String get searchHint => 'ابحث عن الأزياء، الإكسسوارات...';

  @override
  String get categories => 'الأقسام';

  @override
  String get all => 'الكل';

  @override
  String get products => 'المنتجات';

  @override
  String itemsCount(int count) {
    return '$count منتج';
  }

  @override
  String get noProductsFound => 'لا توجد منتجات مطابقة للبحث';

  @override
  String get errorLoadingData => 'حدث خطأ أثناء تحميل البيانات';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get productDetails => 'تفاصيل المنتج';

  @override
  String inStock(int count) {
    return 'متوفر بالمخزون ($count)';
  }

  @override
  String get outOfStock => 'نفد من المخزون';

  @override
  String reviewsCount(int count) {
    return '$count تقييم';
  }

  @override
  String get description => 'الوصف';

  @override
  String get noDescription => 'لا يوجد وصف متوفر لهذا المنتج.';

  @override
  String get addToCart => 'إضافة إلى السلة';

  @override
  String addedToCart(String name) {
    return 'تمت إضافة $name إلى السلة!';
  }

  @override
  String get deleteProduct => 'حذف المنتج';

  @override
  String get confirmDeleteTitle => 'تأكيد الحذف';

  @override
  String confirmDeleteMessage(String name) {
    return 'هل أنت متأكد من حذف المنتج \"$name\"؟';
  }

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get deleteSuccess => 'تم حذف المنتج بنجاح!';

  @override
  String get logout => 'تسجيل الخروج';
}
