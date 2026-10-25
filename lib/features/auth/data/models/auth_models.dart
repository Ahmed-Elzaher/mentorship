class LoginRequestModel {
  final String email;
  final String password;

  const LoginRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email.trim(),
      'password': password,
    };
  }
}

class RegisterRequestModel {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const RegisterRequestModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email.trim(),
      'password': password,
      'firstName': firstName.trim(),
      'lastName': lastName.trim(),
    };
  }
}

class VerifyEmailRequestModel {
  final String email;
  final String otp;

  const VerifyEmailRequestModel({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email.trim(),
      'otp': otp.trim(),
    };
  }
}

class AuthResponseModel {
  final String accessToken;
  final String refreshToken;
  final String? expiresAtUtc;

  const AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
    this.expiresAtUtc,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      expiresAtUtc: json['expiresAtUtc'],
    );
  }
}
