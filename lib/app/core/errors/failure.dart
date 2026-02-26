abstract class Failure {
  final String errorMessage;

  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});
}

class CacheFailure extends Failure {
  CacheFailure({required super.errorMessage});
}

class StoreFailure extends Failure {
  StoreFailure({required super.errorMessage});
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({required super.errorMessage});
}

class GenericFailure extends Failure {
  GenericFailure({required super.errorMessage});
}

class BadResponseFailure extends Failure {
  BadResponseFailure({required super.errorMessage});
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.errorMessage});
}

class InvalidTokenFailure extends Failure {
  InvalidTokenFailure({required super.errorMessage});
}
