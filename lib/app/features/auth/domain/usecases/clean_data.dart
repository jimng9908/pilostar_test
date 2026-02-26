import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:dartz/dartz.dart';

class CleanDataUsecase {
  final AuthRepository repository;

  CleanDataUsecase(this.repository);
  Future<Either<Failure, void>> call() async {
    final resposne = await repository.cleanData();
    return Right(resposne);
  }
}
