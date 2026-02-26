import 'package:get_it/get_it.dart';
import 'package:rockstardata_apk/app/features/profile/data/repo/profile_repo_impl.dart';
import 'package:rockstardata_apk/app/features/profile/index.dart';

void initProfileInjection(GetIt sl) {
  // Repositories
  sl.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl());

  // Blocs - CAMBIAR A registerLazySingleton
  sl.registerLazySingleton(
    () => ProfileBloc(sl())..add(LoadProfile()),
  );
}