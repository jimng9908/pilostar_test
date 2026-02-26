import 'package:equatable/equatable.dart';

class DatasourcesResponse extends Equatable {
  final int id;
  final String? apiKey;
  final String? token;
  final int userId;
  final int sourceId;
  final String? email;
  final String? password;

  const DatasourcesResponse(
      {required this.id,
      this.apiKey,
      this.token,
      required this.userId,
      required this.sourceId,
      this.email,
      this.password});

  @override
  List<Object?> get props => [id, apiKey, token, userId, sourceId, email, password];
}
