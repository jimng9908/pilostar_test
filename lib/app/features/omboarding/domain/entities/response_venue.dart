import 'package:equatable/equatable.dart';

class ResponseVenue extends Equatable {
    const ResponseVenue({
        required this.id,
        required this.name,
        required this.companyId,
        required this.organizationId,
        required this.type,
        required this.isActive,
        required this.delivery,
        required this.takeaway,
        required this.createdAt,
    });

    final int? id;
    final String? name;
    final int? companyId;
    final int? organizationId;
    final String? type;
    final bool? isActive;
    final bool? delivery;
    final bool? takeaway;
    final DateTime? createdAt;

    @override
    List<Object?> get props => [
    id, name, companyId, organizationId, type, isActive, delivery, takeaway, createdAt, ];
}
