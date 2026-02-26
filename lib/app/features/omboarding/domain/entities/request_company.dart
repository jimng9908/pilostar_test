import 'package:equatable/equatable.dart';

class RequestCompany extends Equatable {
  final String name;
  final String address;
  final String phone;
  final String email;
  final String website;
  final int organizationId;

  const RequestCompany({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.website,
    required this.organizationId,
  });

  @override
  List<Object?> get props => [
        name,
        address,
        phone,
        email,
        website,
        organizationId,
      ];
}