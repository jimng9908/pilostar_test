import 'package:rockstardata_apk/app/features/home/index.dart';

class TestDataModel {
  final String companyName = 'PALLAPIZZA';
  final String venueName = 'PAMPLONA';
  final String startDate;
  final String endDate;
  final String compare;
  const TestDataModel({
    required this.startDate,
    required this.endDate,
    required this.compare,
  });
  factory TestDataModel.fromFilter(DashboardFilter filter) {
    String compare = 'day';
    String startDate = DateTime.now().toString();
    String endDate = DateTime.now().toString();
    final now = DateTime.now();

    switch (filter) {
      case DashboardFilter.ayer:
        //Fecha de ayer
        startDate = now.subtract(const Duration(days: 1)).toString();
        compare = 'day';
        break;
      case DashboardFilter.hoy:
        compare = 'day';
        break;
      case DashboardFilter.mes:
        //Primer día del mes actual
        startDate = DateTime(now.year, now.month, 1).toString();
        compare = 'month';
        break;
      case DashboardFilter
            .semana: //no se permite en endpoints de estos indicadores
        //Primer día del año actual
        startDate = DateTime(now.year, 1, 1).toString();
        compare = 'year';
        break;
    }
    return TestDataModel(
        startDate: startDate, endDate: endDate, compare: compare);
  }
}
