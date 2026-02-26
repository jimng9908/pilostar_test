import 'package:rockstardata_apk/app/features/auth/domain/entities/index.dart';

class LoginRequestModel extends LoginRequest {
  const LoginRequestModel({
    required super.email,
    required super.password,
  });

  factory LoginRequestModel.fromEntity(LoginRequest entity) {
    return LoginRequestModel(
      email: entity.email,
      password: entity.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
