class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);
}

class DoNotExistException implements Exception {
  final String message;

  DoNotExistException(this.message);
}
