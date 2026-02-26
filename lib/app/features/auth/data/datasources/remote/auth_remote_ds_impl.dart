import 'dart:convert';

import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio client;
  final GoogleAuthService googleAuthService;

  AuthRemoteDataSourceImpl({
    required this.client,
    required this.googleAuthService,
  });

  @override
  Future<UserModel?> loginWithGoogle() async {
    try {
      final idToken = await googleAuthService.signInWithGoogle();

      if (idToken == null) {
        return null;
      }
      final response = await http.post(
        Uri.parse('${Constants.baseAuthUrl}/auth/google/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': idToken}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userResponse =
            jsonDecode(response.body)['user'] as Map<String, dynamic>;

        final accessToken = JwtDecoder.decode(
            jsonDecode(response.body)['accessToken'] as String);

        debugPrint('----------------------------->>>>>>>>>>>>> $accessToken');

        final user = UserModel(
          accessToken: jsonDecode(response.body)['accessToken'] as String,
          userId: accessToken['sub'] ?? '',
          name: userResponse['firstName'],
          lastName: userResponse['lastName'],
          email: userResponse['email'] ?? '',
          phoneNumber: accessToken['phone'] ?? '',
          picture: userResponse['picture'] ?? '',
          tokenExpiry:
              DateTime.fromMillisecondsSinceEpoch(accessToken['exp'] * 1000),
        );
        debugPrint('----------------------------->>>>>>>>>>>>> $user');
        return user;
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(
            message: jsonDecode(response.body)['message']);
      } else if (response.statusCode == 409) {
        throw ServerException(message: 'El usuario ya existe');
      } else if (response.statusCode == 500) {
        throw ServerException(message: 'Internal server error');
      } else {
        throw GenericException(
            message: 'login failed: ${jsonDecode(response.body)['message']}');
      }
    } on UnauthorizedException {
      rethrow;
    } on ServerException {
      rethrow;
    } on GenericException {
      rethrow;
    } catch (e) {
      throw GenericException(message: 'Unexpected error: $e');
    }
  }

  @override
  Future<UserModel?> registerWithGoogle() async {
    try {
      final idToken = await googleAuthService.signInWithGoogle();

      if (idToken == null) {
        return null;
      }
      final response = await http.post(
        Uri.parse('${Constants.baseAuthUrl}/auth/google/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': idToken}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(
            '----------------------------->>>>>>>>>>>>> ${response.body}');
        final userResponse =
            jsonDecode(response.body)['user'] as Map<String, dynamic>;

        final accessToken = JwtDecoder.decode(
            jsonDecode(response.body)['accessToken'] as String);

        debugPrint('----------------------------->>>>>>>>>>>>> $accessToken');

        final user = UserModel(
          accessToken: jsonDecode(response.body)['accessToken'] as String,
          userId: accessToken['sub'] ?? '',
          name: userResponse['firstName'],
          lastName: userResponse['lastName'],
          email: userResponse['email'] ?? '',
          phoneNumber: accessToken['phone'] ?? '',
          picture: userResponse['picture'] ?? '',
          tokenExpiry:
              DateTime.fromMillisecondsSinceEpoch(accessToken['exp'] * 1000),
        );
        debugPrint('----------------------------->>>>>>>>>>>>> $user');
        return user;
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(
            message: jsonDecode(response.body)['message']);
      } else if (response.statusCode == 500) {
        throw ServerException(message: 'Internal server error');
      } else {
        throw GenericException(
            message: 'login failed: ${jsonDecode(response.body)['message']}');
      }
    } on UnauthorizedException {
      rethrow;
    } on ServerException {
      rethrow;
    } on GenericException {
      rethrow;
    } catch (e) {
      throw GenericException(message: 'Unexpected error: $e');
    }
  }

  @override
  Future<UserModel> login(LoginRequestModel params) async {
    try {
      // final response = await client.post('/auth/login', data: params.toJson());

      final response = await http.post(
        Uri.parse('${Constants.baseAuthUrl}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = jsonDecode(response.body)['access_token'] as String?;
        if (token == null || token.isEmpty) {
          throw Exception('access_token missing in login response');
        }

        final accessToken = JwtDecoder.decode(token);

        final user = UserModel(
          accessToken: token,
          userId: accessToken['sub'] ?? '',
          name: accessToken['name'],
          lastName: accessToken['lastName'],
          email: accessToken['email'] ?? '',
          phoneNumber: accessToken['phone'],
          picture: accessToken['picture'] ?? '',
          organizationName: accessToken['organization'] ?? '',
          companyName: (accessToken['companies'] is List &&
                  (accessToken['companies'] as List).isNotEmpty)
              ? (accessToken['companies'] as List).first.toString()
              : (accessToken['companies']?.toString() ?? ''),
          venueName: (accessToken['venues'] is List &&
                  (accessToken['venues'] as List).isNotEmpty)
              ? (accessToken['venues'] as List).first.toString()
              : (accessToken['venues']?.toString() ?? ''),
          tokenExpiry:
              DateTime.fromMillisecondsSinceEpoch(accessToken['exp'] * 1000),
        );
        debugPrint('----------------------------->>>>>>>>>>>>> $user');
        return user;
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Credenciales invalidas');
      } else if (response.statusCode == 500) {
        throw ServerException(message: 'Internal server error');
      } else {
        throw GenericException(message: 'Login error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException(
          message: 'Error de red: Tiempo de espera agotado',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(
          message: 'Error de red: No hay conexión a Internet',
        );
      } else {
        throw GenericException(
          message: 'Error inesperado: ${e.message}',
        );
      }
    } on ServerException {
      rethrow;
    } on UnauthorizedException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on GenericException {
      rethrow;
    } catch (e) {
      throw GenericException(message: 'Unexpected error: $e');
    }
  }

  @override
  Future<RegisterResponseModel> register(RegisterRequestModel params) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseAuthUrl}/users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(params.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegisterResponseModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        throw ServerException(message: 'Invalid data or user already exists');
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Unauthorized');
      } else if (response.statusCode == 500) {
        throw ServerException(message: 'Internal server error');
      } else {
        throw GenericException(
            message: 'register failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException(
          message: 'Error de red: Tiempo de espera agotado',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(
          message: 'Error de red: No hay conexión a Internet',
        );
      } else {
        throw GenericException(
          message: 'Error inesperado: ${e.message}',
        );
      }
    } on ServerException {
      rethrow;
    } on UnauthorizedException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on GenericException {
      rethrow;
    } catch (e) {
      throw GenericException(message: 'Unexpected error: $e');
    }
  }

  @override
  Future<bool> verifyBusinessConfiguration(
      String accessToken, int userId) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.baseAuthUrl}/users/$userId/check-completeness'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );
      if (response.statusCode == 200) {
        final body = response.body;
        return jsonDecode(body) as bool;
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Unauthorized');
      } else if (response.statusCode == 500) {
        throw ServerException(message: 'Internal server error');
      } else {
        throw GenericException(
            message: 'Login failed after registration: ${response.statusCode}');
      }
    } on ServerException {
      rethrow;
    } on UnauthorizedException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw GenericException(message: 'Unexpected error: $e');
    }
  }

  @override
  Future<UserModel> verifyCode(
      String email, String code, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseAuthUrl}/users/verify-email'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'code': code}),
      );
      if (response.statusCode == 201) {
        final resp = await http.post(
          Uri.parse('${Constants.baseAuthUrl}/auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
              LoginRequestModel(email: email, password: password).toJson()),
        );
        if (resp.statusCode == 200) {
          final token = jsonDecode(resp.body)['access_token'] as String?;
          if (token == null || token.isEmpty) {
            throw Exception('access_token missing in login response');
          }

          final accessToken = JwtDecoder.decode(token);

          final user = UserModel(
            accessToken: token,
            userId: accessToken['sub'] ?? '',
            name: accessToken['name'],
            lastName: accessToken['lastName'],
            email: accessToken['email'] ?? '',
            phoneNumber: accessToken['phone'],
            picture: accessToken['picture'] ?? '',
            organizationName: accessToken['organization'] ?? '',
            companyName: (accessToken['companies'] is List &&
                    (accessToken['companies'] as List).isNotEmpty)
                ? (accessToken['companies'] as List).first.toString()
                : (accessToken['companies']?.toString() ?? ''),
            venueName: (accessToken['venues'] is List &&
                    (accessToken['venues'] as List).isNotEmpty)
                ? (accessToken['venues'] as List).first.toString()
                : (accessToken['venues']?.toString() ?? ''),
            tokenExpiry:
                DateTime.fromMillisecondsSinceEpoch(accessToken['exp'] * 1000),
          );
          debugPrint('----------------------------->>>>>>>>>>>>> $user');
          return user;
        } else {
          throw Exception('Failed to login after verification');
        }
      } else if (response.statusCode == 400) {
        throw BadResponseException(message: 'El código es incorrecto');
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Unauthorized');
      } else if (response.statusCode == 500) {
        throw ServerException(message: 'Internal server error');
      } else {
        throw GenericException(
            message: 'Login failed after registration: ${response.statusCode}');
      }
    } on ServerException {
      rethrow;
    } on UnauthorizedException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on BadResponseException {
      rethrow;
    } catch (e) {
      throw GenericException(message: 'Unexpected error: $e');
    }
  }
}
