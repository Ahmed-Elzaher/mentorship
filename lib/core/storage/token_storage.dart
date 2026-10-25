import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  static String? _cachedAccessToken;
  static String? _cachedRefreshToken;

  static String? get cachedAccessToken => _cachedAccessToken;

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _cachedAccessToken = prefs.getString(_accessTokenKey);
    _cachedRefreshToken = prefs.getString(_refreshTokenKey);
  }

  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _cachedAccessToken = accessToken;
    _cachedRefreshToken = refreshToken;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
  }

  static Future<String?> getAccessToken() async {
    if (_cachedAccessToken != null) return _cachedAccessToken;
    final prefs = await SharedPreferences.getInstance();
    _cachedAccessToken = prefs.getString(_accessTokenKey);
    return _cachedAccessToken;
  }

  static Future<String?> getRefreshToken() async {
    if (_cachedRefreshToken != null) return _cachedRefreshToken;
    final prefs = await SharedPreferences.getInstance();
    _cachedRefreshToken = prefs.getString(_refreshTokenKey);
    return _cachedRefreshToken;
  }

  static Future<void> clearTokens() async {
    _cachedAccessToken = null;
    _cachedRefreshToken = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
  }
}
