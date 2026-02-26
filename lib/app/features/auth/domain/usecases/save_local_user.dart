import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:dartz/dartz.dart';

class SaveLocalUserUsecase {
  final AuthRepository repository;

  SaveLocalUserUsecase(this.repository);

  Future<Either<Failure, void>> call(UserEntity user) async {
    return await repository.saveLocalUser(user);
  }
}
