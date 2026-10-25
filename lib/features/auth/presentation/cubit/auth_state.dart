import 'package:mentorship/features/auth/data/models/auth_models.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  final String? message;
  const AuthLoading({this.message});
}

class LoginSuccess extends AuthState {
  final AuthResponseModel response;
  const LoginSuccess(this.response);
}

class RegisterSuccess extends AuthState {
  final String email;
  const RegisterSuccess(this.email);
}

class VerifyEmailSuccess extends AuthState {
  const VerifyEmailSuccess();
}

class RefreshTokenSuccess extends AuthState {
  final AuthResponseModel response;
  const RefreshTokenSuccess(this.response);
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}
