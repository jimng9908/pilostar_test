import 'package:dartz/dartz.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';

class VerifyBusinessConfig {
  final AuthRepository authRepository;

  VerifyBusinessConfig(this.authRepository);

  Future<Either<Failure, bool>> call(String accessToken, int userId) async {
    return await authRepository.verifyBusinessConfiguration(
        accessToken, userId);
  }
}
