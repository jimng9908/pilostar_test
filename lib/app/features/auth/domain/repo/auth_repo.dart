import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(LoginRequest params);
  Future<Either<Failure, UserEntity>> loginWithGoogle();
  Future<Either<Failure, UserEntity>> registerWithGoogle();
  Future<Either<Failure, RegisterResponse>> register(RegisterRequest params);
    Future<Either<Failure, UserEntity>> verifyCode(String email, String code, String password);
  Future<Either<Failure, void>> saveLocalUser(UserEntity user);
  Future<Either<Failure, UserModel?>> getLocalUser();
  Future<void> cleanData();
  Future<Either<Failure, bool>> verifyBusinessConfiguration(
      String accessToken, int userId);
}
