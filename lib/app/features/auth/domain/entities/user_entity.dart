import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String accessToken;
  final int userId;
  final String? name;
  final String? lastName;
  final String email;
  final String? phoneNumber;
  final String? picture;
  final Role? role;
  final bool? isActive;
  final String? organizationName;
  final String? companyName;
  final String? venueName;
  final DateTime? tokenExpiry;

  const UserEntity(
      {required this.accessToken,
      required this.userId,
      this.name,
      this.lastName,
      required this.email,
      this.phoneNumber,
      this.picture,
      this.role,
      this.isActive,
      this.organizationName,
      this.companyName,
      this.venueName,
      this.tokenExpiry});

  static UserEntity empty() {
    return UserEntity(
        accessToken: '',
        userId: 0,
        name: '',
        lastName: '',
        email: '',
        phoneNumber: '',
        picture: '',
        role: Role.empty(),
        isActive: false,
        organizationName: '',
        companyName: '',
        venueName: '',
        tokenExpiry: null);
  }

  @override
  List<Object> get props => [accessToken, userId, email];
}

class Role extends Equatable {
  final String name;

  const Role({required this.name});

  static Role empty() => const Role(name: '');

  @override
  List<Object> get props => [name];
}
