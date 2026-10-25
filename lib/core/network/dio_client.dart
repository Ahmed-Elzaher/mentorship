import 'package:dio/dio.dart';
import 'package:mentorship/core/network/api_constants.dart';
import 'package:mentorship/core/storage/token_storage.dart';

class DioClient {
  static Dio? _dio;

  static Dio get instance {
    _dio ??= _createDio();
    return _dio!;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = TokenStorage.cachedAccessToken;
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) {
          return handler.next(error);
        },
      ),
    );

    return dio;
  }

  static String handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'انتهت مهلة الاتصال بالخادم. يرجى التحقق من اتصال الإنترنت.';
        case DioExceptionType.badResponse:
          final response = error.response;
          if (response?.data != null) {
            final data = response!.data;
            if (data is Map<String, dynamic>) {
              if (data['detail'] != null) {
                return data['detail'].toString();
              }
              if (data['message'] != null) {
                return data['message'].toString();
              }
              if (data['title'] != null) {
                return data['title'].toString();
              }
              if (data['errors'] != null) {
                final errors = data['errors'];
                if (errors is Map) {
                  return errors.values.map((e) => e is List ? e.join(', ') : e.toString()).join('\n');
                }
                return errors.toString();
              }
            } else if (data is String) {
              return data;
            }
          }
          return 'حدث خطأ في الخادم (رمز الحالة: ${response?.statusCode})';
        case DioExceptionType.cancel:
          return 'تم إلغاء الطلب.';
        case DioExceptionType.connectionError:
          return 'تعذر الاتصال بالخادم. تأكد من اتصال الإنترنت.';
        case DioExceptionType.badCertificate:
          return 'شهادة أمان غير صالحة.';
        case DioExceptionType.unknown:
        default:
          return 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.';
      }
    }
    return error.toString();
  }
}
