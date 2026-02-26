import 'package:equatable/equatable.dart';

class RegisterRequest extends Equatable {
  final String name;
  final String lastName;
  final String email;
  final String password;
  final String? phoneNumber;
  // final String? address;
  // final String? locality;
  // final String? country;
  final bool isActive;

  const RegisterRequest({
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    this.phoneNumber,
    // this.address,
    // this.locality,
    // this.country,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [name, lastName, email, password];
}
