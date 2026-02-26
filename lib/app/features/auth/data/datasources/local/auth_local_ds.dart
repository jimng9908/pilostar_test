import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:dartz/dartz.dart';

abstract class AuthLocalDataSource {
  Future<Either<Failure, void>> saveLocalUser(UserEntity user);
  Future<UserModel?> getLocalUser();
  Future<void> clearData();
}
