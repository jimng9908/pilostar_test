import 'package:dartz/dartz.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';

class VerifyCode {
  final AuthRepository repository;
  VerifyCode(this.repository);

  Future<Either<Failure, UserEntity>> call(
      String email, String code, String password) async {
    return await repository.verifyCode(email, code, password);
  }
}
