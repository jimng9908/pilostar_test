import 'package:equatable/equatable.dart';

class Company extends Equatable {
  const Company({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.website,
    required this.organizationId,
    required this.isActive,
    required this.createdAt,
  });

  final int? id;
  final String? name;
  final String? address;
  final String? phone;
  final String? email;
  final String? website;
  final int? organizationId;
  final bool? isActive;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        phone,
        email,
        website,
        organizationId,
        isActive,
        createdAt,
      ];
}
