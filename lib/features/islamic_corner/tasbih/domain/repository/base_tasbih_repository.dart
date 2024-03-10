import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/failure.dart';

import '../entities/tasbih.dart';

abstract class BaseTasbihRepository {
  Future<Either<Failure, List<Tasbih>>> getAllTasbih();
}
