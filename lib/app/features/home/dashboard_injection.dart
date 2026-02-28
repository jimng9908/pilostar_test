import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:rockstardata_apk/app/features/home/data/datasources/remote/home_remote_data_source.dart';
import 'package:rockstardata_apk/app/features/home/data/datasources/remote/home_remote_data_source_impl.dart';
import 'package:rockstardata_apk/app/features/home/domain/repo/index.dart';
import 'package:rockstardata_apk/app/features/home/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:rockstardata_apk/app/features/home/data/repo/index.dart';

void dashboardInjection(GetIt sl) {
  //Repositories
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(
      dio: sl<Dio>(instanceName: 'authDio'),
    ),
  );

  sl.registerLazySingleton<HomeRepo>(
    () => DashboardRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // sl.registerLazySingleton<DashboardRepositoryImpl>(() => DashboardRepositoryImpl());

  //BLocs
  sl.registerFactory(
    () => DashboardBloc(
      repository: sl(),
    ),
  );
}
