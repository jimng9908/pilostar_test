import 'package:rockstardata_apk/app/features/auth/auth.dart';

class RegisterRequestModel {
  final String name;
  final String lastName;
  final String email;
  final String password;
  final String? phoneNumber;
  // final String? address;
  // final String? locality;
  // final String? country;
  final bool isActive;

  const RegisterRequestModel(
      {required this.name,
      required this.lastName,
      required this.email,
      required this.password,
      this.phoneNumber,
      // this.address,
      // this.locality,
      // this.country,
      this.isActive = true});

  factory RegisterRequestModel.fromEntity(RegisterRequest entity) {
    return RegisterRequestModel(
        name: entity.name,
        lastName: entity.lastName,
        email: entity.email,
        password: entity.password,
        phoneNumber: entity.phoneNumber,
        // address: entity.address,
        // locality: entity.locality,
        // country: entity.country,
        isActive: entity.isActive);
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': name,
      'lastName': lastName,
      'phone': phoneNumber,
      'email': email,
      'password': password,
      // 'address': address,
      // 'locality': locality,
      // 'country': country,
      'isActive': isActive
    };
  }
}
