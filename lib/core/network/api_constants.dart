abstract class ApiConstants {
  static const String baseUrl = 'https://accessories-eshop.runasp.net/api/';

  // Auth Endpoints
  static const String register = 'auth/register';
  static const String verifyEmail = 'auth/verify-email';
  static const String login = 'auth/login';
  static const String refreshToken = 'auth/refresh-token';

  // Products Endpoints
  static const String products = 'products';
  static String productDetails(String id) => 'products/$id';
  static String deleteProduct(String id) => 'products/$id';

  // Categories Endpoints
  static const String categories = 'categories';
  static String categoryDetails(String id) => 'categories/$id';
}
