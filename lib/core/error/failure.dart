import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
  @override
  List<Object> get props => [message];
}

class EmpatyCacheFailure extends Failure {
  const EmpatyCacheFailure(super.message);
  @override
  List<Object> get props => [message];
}

class OfflineFailure extends Failure {
  const OfflineFailure(super.message);
  @override
  List<Object> get props => [message];
}

class LocalDataBaseFailure extends Failure {
  const LocalDataBaseFailure(super.message);
  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
  @override
  List<Object> get props => [message];
}
