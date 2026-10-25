import 'package:dio/dio.dart';
import 'package:mentorship/core/network/api_constants.dart';
import 'package:mentorship/core/network/dio_client.dart';
import 'package:mentorship/core/storage/token_storage.dart';
import 'package:mentorship/features/auth/data/models/auth_models.dart';

class AuthService {
  final Dio _dio = DioClient.instance;

  Future<AuthResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: request.toJson(),
      );

      final authResponse = AuthResponseModel.fromJson(response.data);
      await TokenStorage.saveTokens(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
      );
      return authResponse;
    } catch (e) {
      throw DioClient.handleError(e);
    }
  }

  Future<void> register(RegisterRequestModel request) async {
    try {
      await _dio.post(
        ApiConstants.register,
        data: request.toJson(),
      );
    } catch (e) {
      throw DioClient.handleError(e);
    }
  }

  Future<void> verifyEmail(VerifyEmailRequestModel request) async {
    try {
      await _dio.post(
        ApiConstants.verifyEmail,
        data: request.toJson(),
      );
    } catch (e) {
      throw DioClient.handleError(e);
    }
  }

  Future<AuthResponseModel> refreshToken() async {
    try {
      final currentRefreshToken = await TokenStorage.getRefreshToken();
      if (currentRefreshToken == null || currentRefreshToken.isEmpty) {
        throw 'لا يوجد Refresh Token متاح لتجديد الجلسة.';
      }

      final response = await _dio.post(
        ApiConstants.refreshToken,
        data: {
          'refreshToken': currentRefreshToken,
          'useCookies': false,
        },
      );

      final authResponse = AuthResponseModel.fromJson(response.data);
      await TokenStorage.saveTokens(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
      );
      return authResponse;
    } catch (e) {
      throw DioClient.handleError(e);
    }
  }
}
