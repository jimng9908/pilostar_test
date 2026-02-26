import 'package:equatable/equatable.dart';

class DatasourceRequest extends Equatable {
  final int dataSourceId;
  final String? apiKey;
  final String? token;
  final String? email;
  final String? password;

  const DatasourceRequest({
    required this.dataSourceId,
    this.apiKey,
    this.token,
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [dataSourceId, apiKey, token, email, password];
}
