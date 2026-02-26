import 'package:rockstardata_apk/app/core/core.dart';
import 'package:dartz/dartz.dart';

import 'package:rockstardata_apk/app/features/auth/auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<void> cleanData() async {
    await localDataSource.clearData();
  }

  @override
  Future<Either<Failure, UserModel?>> getLocalUser() async {
    try {
      final userModel = await localDataSource.getLocalUser();
      if (userModel != null) {
        return Right(userModel);
      } else {
        return Left(CacheFailure(errorMessage: 'No hay datos almacenados'));
      }
    } catch (e) {
      return Left(
          CacheFailure(errorMessage: 'Error retrieving local user: $e'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(LoginRequest params) async {
    try {
      final user =
          await remoteDataSource.login(LoginRequestModel.fromEntity(params));
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(errorMessage: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(errorMessage: e.message));
    } on GenericException catch (e) {
      return Left(GenericFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle() async {
    try {
      final user = await remoteDataSource.loginWithGoogle();
      if (user != null) {
        return Right(user.toEntity());
      } else {
        return Left(GenericFailure(errorMessage: 'Inicio de sesión cancelado'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(errorMessage: e.message));
    } on GenericException catch (e) {
      return Left(GenericFailure(
          errorMessage: 'Error en Google Sign-In: ${e.message}'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> registerWithGoogle() async {
    try {
      final user = await remoteDataSource.registerWithGoogle();
      if (user != null) {
        return Right(user.toEntity());
      } else {
        return Left(GenericFailure(errorMessage: 'Registro cancelado'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(errorMessage: e.message));
    } on GenericException catch (e) {
      return Left(GenericFailure(
          errorMessage: 'Error en Google Sign-In: ${e.message}'));
    }
  }

  @override
  Future<Either<Failure, RegisterResponse>> register(
      RegisterRequest params) async {
    try {
      final response = await remoteDataSource
          .register(RegisterRequestModel.fromEntity(params));
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(errorMessage: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(errorMessage: e.message));
    } on GenericException catch (e) {
      return Left(GenericFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveLocalUser(UserEntity user) async {
    try {
      await localDataSource.saveLocalUser(user);
      return Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyBusinessConfiguration(
      String accessToken, int userId) async {
    try {
      final response = await remoteDataSource.verifyBusinessConfiguration(
          accessToken, userId);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(errorMessage: e.message));
    } on GenericException catch (e) {
      return Left(GenericFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifyCode(
      String email, String code, String password) async {
    try {
      final user = await remoteDataSource.verifyCode(email, code, password);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(errorMessage: e.message));
    } on GenericException catch (e) {
      return Left(GenericFailure(errorMessage: e.message));
    } on BadResponseException catch (e) {
      return Left(BadResponseFailure(errorMessage: e.message));
    }
  }
}
