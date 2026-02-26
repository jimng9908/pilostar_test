import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:dartz/dartz.dart';

class LoginUserUsecase {
  final AuthRepository repository;

  LoginUserUsecase(this.repository);

  Future<Either<Failure, UserEntity>> call(LoginRequest params) async {
    return await repository.login(params);
  }
}
