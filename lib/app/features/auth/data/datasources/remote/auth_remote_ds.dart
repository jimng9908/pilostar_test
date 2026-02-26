import 'package:rockstardata_apk/app/features/auth/auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(LoginRequestModel params);
  Future<RegisterResponseModel> register(RegisterRequestModel params);
  Future<UserModel> verifyCode(String email, String code, String password);
  Future<UserModel?> loginWithGoogle();
  Future<UserModel?> registerWithGoogle();
  Future<bool> verifyBusinessConfiguration(String accessToken, int userId);
}
