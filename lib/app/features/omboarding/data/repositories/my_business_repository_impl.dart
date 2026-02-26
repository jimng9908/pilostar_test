import 'package:dartz/dartz.dart';
import 'package:rockstardata_apk/app/core/errors/failure.dart';
import 'package:rockstardata_apk/app/core/errors/exception.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class MyBusinessRepositoryImpl implements MyBusinessRepository {
  final MyBusinessRemoteDataSource remoteDataSource;

  MyBusinessRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<BusinessInformation>>> getBusinessInfo(
      String placeUrl, String accessToken) async {
    try {
      final info =
          await remoteDataSource.getBusinessInfo(placeUrl, accessToken);
      return Right(info);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on ServiceException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on GenericException catch (e) {
      return Left(GenericFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, Company>> createCompany(
      RequestCompany requestCompany, String accessToken) async {
    try {
      final params = RequestCompanyModel.fromEntity(requestCompany);
      final remoteResponse =
          await remoteDataSource.createCompany(params, accessToken);
      return Right(remoteResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on ServiceException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on GenericException catch (e) {
      return Left(GenericFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, Organization>> createOrganization(
      String name, String nif, String accessToken) async {
    try {
      final remoteResponse =
          await remoteDataSource.createOrganization(name, nif, accessToken);
      return Right(remoteResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on ServiceException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on GenericException catch (e) {
      return Left(GenericFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, ResponseVenue>> createVenue(
      RequestVenue requestVenue, String accessToken) async {
    try {
      final params = RequestVenueModel.fromEntity(requestVenue);
      final remoteResponse =
          await remoteDataSource.createVenue(params, accessToken);
      return Right(remoteResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on ServiceException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on GenericException catch (e) {
      return Left(GenericFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, List<DatasourcesResponse>>> connectDataSources(
      List<DatasourceRequest> datasourceRequestModels,
      String accessToken) async {
    try {
      final models = datasourceRequestModels
          .map((e) => DatasourceRequestModel.fromEntity(e))
          .toList();
      final remoteResponse =
          await remoteDataSource.connectDataSources(models, accessToken);
      return Right(remoteResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on ServiceException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on GenericException catch (e) {
      return Left(GenericFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, ResponseAutoConfig>> startAutomaticConfiguration(
      RequestAutoConfig requestAutoConfig, String accessToken) async {
    try {
      final params = RequestAutoConfigModel.fromEntity(requestAutoConfig);
      final remoteResponse = await remoteDataSource.startAutomaticConfiguration(
          params, accessToken);
      return Right(remoteResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on ServiceException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on GenericException catch (e) {
      return Left(GenericFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<KpiEntity>>> getKpisByUserId(
      String accessToken, int userId) async {
    try {
      final remoteResponse =
          await remoteDataSource.getKpiListByUserId(accessToken, userId);
      return Right(remoteResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on ServiceException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on GenericException catch (e) {
      return Left(GenericFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, List<ResponseKpiPreferences>>> submitKpiPreferences(
      String accessToken, List<RequestKpiPreferences> kpiModels) async {
    final models =
        kpiModels.map((e) => RequestKpiPreferencesModel.fromEntity(e)).toList();
    try {
      final remoteResponse =
          await remoteDataSource.submitKpiPreferences(accessToken, models);
      return Right(remoteResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on ServiceException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on GenericException catch (e) {
      return Left(GenericFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, ResponseGoalsEntity>> submitGoals(
      String accessToken, RequestGoalsEntity goals) async {
    final model = RequestGoalsModel.fromEntity(goals);
    try {
      final remoteResponse =
          await remoteDataSource.submitGoals(accessToken, model);
      return Right(remoteResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on ServiceException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } on GenericException catch (e) {
      return Left(GenericFailure(errorMessage: e.message));
    }
  }
}
