import 'package:equatable/equatable.dart';

import '../utils/app_string.dart';

class ServerException extends Equatable implements Exception {
  final String? message;

  const ServerException([this.message]);

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return '$message';
  }
}

class FetchDataException extends ServerException {
  const FetchDataException() : super(AppString.errorDuringCommunication);
}

class BadRequestException extends ServerException {
  const BadRequestException() : super(AppString.badRequest);
}

class NotFoundException extends ServerException {
  const NotFoundException() : super(AppString.requestedInfoNotFound);
}

class ConflictException extends ServerException {
  const ConflictException() : super(AppString.conflictOccurred);
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException() : super(AppString.internalServerError);
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException() : super(AppString.noInternetConnection);
}

class CacheException implements Exception {}
