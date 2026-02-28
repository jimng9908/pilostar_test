import 'package:rockstardata_apk/app/features/home/index.dart';

abstract class HomeRemoteDataSource {
  Future<MetricEntity?> getTotalRevenueAndExpenses(DashboardFilter filter);
  Future<MetricEntity?> getTotalRevenue(DashboardFilter filter);
  Future<MetricEntity?> getCustomers(DashboardFilter filter);
  Future<MetricEntity?> getAverageTicket(DashboardFilter filter);
  Future<MetricEntity?> getPersonalPercentage(DashboardFilter filter);
  Future<MetricEntity?> getMerchandisePercentage(DashboardFilter filter);
  Future<MetricEntity?> getProfitability(DashboardFilter filter);
}
