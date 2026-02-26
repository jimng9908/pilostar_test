import 'package:equatable/equatable.dart';

class ProfileInfo extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String businessName;
  final String businessAddress;
  final String businessType;
  final String nifCif;

  const ProfileInfo({
    required this.name,
    required this.email,
    required this.phone,
    required this.businessName,
    required this.businessAddress,
    required this.businessType,
    required this.nifCif,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        businessName,
        businessAddress,
        businessType,
        nifCif,
      ];

  ProfileInfo copyWith({
    String? name,
    String? email,
    String? phone,
    String? businessName,
    String? businessAddress,
    String? businessType,
    String? nifCif,
  }) {
    return ProfileInfo(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      businessName: businessName ?? this.businessName,
      businessAddress: businessAddress ?? this.businessAddress,
      businessType: businessType ?? this.businessType,
      nifCif: nifCif ?? this.nifCif,
    );
  }
}
