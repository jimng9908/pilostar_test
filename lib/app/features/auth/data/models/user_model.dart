import 'dart:convert';

import 'package:rockstardata_apk/app/features/auth/auth.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.accessToken,
    required super.userId,
    required super.name,
    required super.lastName,
    required super.email,
    super.phoneNumber,
    super.picture,
    super.role,
    super.tokenExpiry,
    super.isActive,
    super.organizationName,
    super.companyName,
    super.venueName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      accessToken: json['accessToken'],
      userId: json['userId'],
      name: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phone'] ?? '',
      picture: json['photoUrl'] ?? '',
      organizationName: json['organizationName'] ?? '',
      companyName: json['companyName'] ?? '',
      venueName: json['venueName'] ?? '',
      tokenExpiry: DateTime.parse(json['tokenExpiry']),
      isActive: json['isActive'],
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
        accessToken: entity.accessToken,
        userId: entity.userId,
        name: entity.name,
        lastName: entity.lastName,
        email: entity.email,
        phoneNumber: entity.phoneNumber,
        picture: entity.picture,
        role: entity.role,
        isActive: entity.isActive,
        organizationName: entity.organizationName,
        companyName: entity.companyName,
        venueName: entity.venueName,
        tokenExpiry: entity.tokenExpiry);
  }

  UserEntity toEntity() => UserEntity(
        accessToken: accessToken,
        userId: userId,
        name: name,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        picture: picture,
        role: role,
        tokenExpiry: tokenExpiry,
        isActive: isActive,
        organizationName: organizationName,
        companyName: companyName,
        venueName: venueName,
      );

  UserModel copyWith({
    String? accessToken,
    int? userId,
    String? name,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? picture,
    RoleModel? role,
    bool? isActive,
    DateTime? tokenExpiry,
    String? organizationName,
    String? companyName,
    String? venueName,
  }) {
    return UserModel(
      accessToken: accessToken ?? this.accessToken,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      picture: picture ?? this.picture,
      email: email ?? this.email,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      tokenExpiry: tokenExpiry ?? this.tokenExpiry,
      organizationName: organizationName ?? this.organizationName,
      companyName: companyName ?? this.companyName,
      venueName: venueName ?? this.venueName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'userId': userId,
      'firstName': name,
      'lastName': lastName,
      'email': email,
      'phone': phoneNumber,
      'picture': picture,
      'role': jsonEncode(role),
      'isActive': isActive,
      'tokenExpiry': tokenExpiry?.toIso8601String(),
      'organizationName': organizationName,
      'companyName': companyName,
      'venueName': venueName,
    };
  }
}

class RoleModel extends Role {
  const RoleModel({
    required super.name,
  });

  factory RoleModel.fromMap(Map<String, List<dynamic>> map) {
    return RoleModel(
      name: map['name']?.first ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
