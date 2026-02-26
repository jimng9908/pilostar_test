import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;
  final AuthLocalDataSource authLocalDataSource;

  TokenInterceptor({
    required this.dio,
    required this.authLocalDataSource,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Agregar token a requests que requieren autenticación
    if (_requiresAuth(options)) {
      final token = await _getStoredAccessToken();

      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    // Validar que sea HTTPS
    if (!options.uri.toString().startsWith('https://')) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'Solo se permiten conexiones HTTPS',
          type: DioExceptionType.connectionError,
        ),
      );
    }

    return super.onRequest(options, handler);
  }

  bool _requiresAuth(RequestOptions options) {
    // Excluir endpoints que no requieren autenticación
    final publicEndpoints = [
      '/auth/login',
      '/auth/register',
      '/auth/refresh',
    ];

    return !publicEndpoints.any((endpoint) => options.path.contains(endpoint));
  }

  Future<String?> _getStoredAccessToken() async {
    final authResponseResult = await authLocalDataSource.getLocalUser();

    if (authResponseResult != null) {
      return authResponseResult.accessToken;
    } else {
      return null;
    }
  }
}
