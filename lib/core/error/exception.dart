
import '../network/error_message_model.dart';

class ServerException implements Exception {
  final ErrorMessageModel errorMessageModel;

  ServerException({required this.errorMessageModel});
}

class EmpatyCacheException implements Exception {
  final String message;

  EmpatyCacheException(this.message);
}

class OfflineException implements Exception {
  final String message;

  OfflineException(this.message);
}

class LocelDataBaseException implements Exception {
  final String message;

  LocelDataBaseException({required this.message});
}

class CacheException implements Exception {}
