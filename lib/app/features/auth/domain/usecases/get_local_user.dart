import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:dartz/dartz.dart';

class GetLocalUserUsecase{
  final AuthRepository repository;

  GetLocalUserUsecase(this.repository);

  Future<Either<Failure, UserEntity?>> call() async {
    return await repository.getLocalUser();
  }
}
