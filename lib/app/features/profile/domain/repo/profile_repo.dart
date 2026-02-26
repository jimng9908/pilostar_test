import '../entities/data_source.dart';

abstract class ProfileRepo {
  Future<List<ProfileDataSource>> getDataSources();
  Future<DataSourcesSummary> getSummary();
}
