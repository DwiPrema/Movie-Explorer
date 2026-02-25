class NetworkException implements Exception {
  String message;

  NetworkException(this.message);
}

class ServerException implements Exception {
  String message;

  ServerException(this.message);
}

class NotFoundException implements Exception {}
