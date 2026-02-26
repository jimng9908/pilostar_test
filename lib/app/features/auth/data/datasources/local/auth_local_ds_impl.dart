import 'dart:convert';

import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> clearData() async {
    await secureStorage.delete(key: Constants.user);
  }

  @override
  Future<UserModel?> getLocalUser() {
    return secureStorage.read(key: Constants.user).then((value) {
      if (value != null) {
        final Map<String, dynamic> userMap = jsonDecode(value);
        return UserModel.fromJson(userMap);
      }
      return null;
    });
  }

  @override
  Future<Either<Failure, void>> saveLocalUser(UserEntity user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      final userJson = jsonEncode(userModel.toJson());
      await secureStorage.write(key: Constants.user, value: userJson);
      return Right(null);
    } catch (e) {
      throw CacheException(message: 'Error almacenando datos');
    }
  }
}
