import 'package:get_it/get_it.dart';
import 'package:rockstardata_apk/app/features/home/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:rockstardata_apk/app/features/home/data/repo/index.dart';

void dashboardInjection(GetIt sl) {

  //Repositories
  sl.registerLazySingleton<DashboardRepositoryImpl>(() => DashboardRepositoryImpl());

  //Blocs
  sl.registerLazySingleton<DashboardBloc>(() => DashboardBloc(sl()));
}