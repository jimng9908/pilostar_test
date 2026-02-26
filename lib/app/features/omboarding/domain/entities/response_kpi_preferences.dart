import 'package:equatable/equatable.dart';

class ResponseKpiPreferences extends Equatable {
  const ResponseKpiPreferences({
    required this.id,
    required this.kpiId,
    required this.kpiName,
    required this.isActive,
  });

  final int? id;
  final int? kpiId;
  final String? kpiName;
  final bool? isActive;

  @override
  List<Object?> get props => [
        id,
        kpiId,
        kpiName,
        isActive,
      ];
}
