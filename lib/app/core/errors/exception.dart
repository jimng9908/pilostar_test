class ServerException implements Exception {
  final String message;

  const ServerException({required this.message});
}

class CacheException implements Exception {
  final String message;

  const CacheException({required this.message});
}
class ServiceException implements Exception {
  final String message;

  const ServiceException({required this.message});
}

class StoreException implements Exception {
  final String message;

  const StoreException({required this.message});
}

class GenericException implements Exception {
  final String message;

  const GenericException({required this.message});
}
class BadResponseException implements Exception {
  final String message;

  const BadResponseException({required this.message});
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({required this.message});
}

class UnauthorizedException implements Exception {
  final String message;

  const UnauthorizedException({required this.message});
}

class InvalidTokenException implements Exception {
  final String message;

  const InvalidTokenException({required this.message});
}
