import 'package:get_it/get_it.dart';
import 'package:rockstardata_apk/app/features/finanzas/presentation/bloc/finanzas_bloc.dart';

void initFinanceInjection(GetIt sl) {
  sl.registerFactory(() => FinanzasBloc());
}
