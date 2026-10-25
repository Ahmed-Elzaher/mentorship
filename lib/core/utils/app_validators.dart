class AppValidators {
  static String? validateEmail({
    required String? value,
    required String requiredMessage,
    required String invalidMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return requiredMessage;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return invalidMessage;
    }
    return null;
  }

  static String? validatePassword({
    required String? value,
    required String requiredMessage,
    required String minLengthMessage,
  }) {
    if (value == null || value.isEmpty) {
      return requiredMessage;
    }
    if (value.length < 6) {
      return minLengthMessage;
    }
    return null;
  }

  static String? validateRequired({
    required String? value,
    required String requiredMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return requiredMessage;
    }
    return null;
  }
}
