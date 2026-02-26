import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:dartz/dartz.dart';

class RegisterWithGoogleUseCase {
  final AuthRepository repository;

  RegisterWithGoogleUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call() async {
    return await repository.registerWithGoogle();
  }
}
