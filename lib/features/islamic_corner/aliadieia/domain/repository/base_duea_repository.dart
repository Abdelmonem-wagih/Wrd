import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/failure.dart';

import '../entities/duea.dart';

abstract class BaseDueaRepository {
  Future<Either<Failure, List<Duea>>> getAllAliadieia();
}
