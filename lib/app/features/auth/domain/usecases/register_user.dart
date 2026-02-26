import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:dartz/dartz.dart';

class RegisterUserUseCases {
  final AuthRepository repository;

  RegisterUserUseCases(this.repository);

  Future<Either<Failure, RegisterResponse>> call(RegisterRequest params) async {
    return await repository.register(params);
  }
}
