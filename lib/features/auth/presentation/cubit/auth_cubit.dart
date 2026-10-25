import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship/features/auth/data/auth_service.dart';
import 'package:mentorship/features/auth/data/models/auth_models.dart';
import 'package:mentorship/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit({AuthService? authService})
      : _authService = authService ?? AuthService(),
        super(const AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading(message: 'جاري تسجيل الدخول...'));
    try {
      final response = await _authService.login(
        LoginRequestModel(email: email, password: password),
      );
      emit(LoginSuccess(response));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    emit(const AuthLoading(message: 'جاري إنشاء الحساب...'));
    try {
      await _authService.register(
        RegisterRequestModel(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
        ),
      );
      emit(RegisterSuccess(email));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> verifyEmail({required String email, required String otp}) async {
    emit(const AuthLoading(message: 'جاري التحقق من الرمز...'));
    try {
      await _authService.verifyEmail(
        VerifyEmailRequestModel(email: email, otp: otp),
      );
      emit(const VerifyEmailSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> refreshToken() async {
    emit(const AuthLoading(message: 'جاري تجديد الجلسة...'));
    try {
      final response = await _authService.refreshToken();
      emit(RefreshTokenSuccess(response));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
