import 'package:rockstardata_apk/app/features/home/data/datasources/remote/index.dart';
import 'package:rockstardata_apk/app/features/home/index.dart';

class DashboardRepositoryImpl implements HomeRepo {
  final HomeRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<MetricEntity?> getTotalRevenueAndExpenses(DashboardFilter filter) {
    return remoteDataSource.getTotalRevenueAndExpenses(filter);
  }

  @override
  Future<MetricEntity?> getTotalRevenue(DashboardFilter filter) {
    return remoteDataSource.getTotalRevenue(filter);
  }

  Future<MetricEntity?> getCustomers(DashboardFilter filter) {
    return remoteDataSource.getTotalRevenue(filter);
  }

  @override
  Future<MetricEntity?> getAverageTicket(DashboardFilter filter) {
    return remoteDataSource.getAverageTicket(filter);
  }

  @override
  Future<MetricEntity?> getPersonalPercentage(DashboardFilter filter) {
    return remoteDataSource.getPersonalPercentage(filter);
  }

  @override
  Future<MetricEntity?> getMerchandisePercentage(DashboardFilter filter) {
    return remoteDataSource.getMerchandisePercentage(filter);
  }

  @override
  Future<MetricEntity?> getProfitability(DashboardFilter filter) {
    return remoteDataSource.getProfitability(filter);
  }
}
