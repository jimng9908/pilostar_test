import 'package:equatable/equatable.dart';

class RequestKpiPreferences extends Equatable {
    const RequestKpiPreferences({
        required this.kpiId,
        required this.isActive,
    });

    final int kpiId;
    final bool isActive;

    @override
    List<Object?> get props => [kpiId, isActive];
}