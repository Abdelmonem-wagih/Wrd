import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/failure.dart';

import '../entities/azkar_entities/azkar.dart';
import '../entities/haju_entities/haju.dart';
import '../entities/says_entities/says.dart';
import '../entities/tashahhud_entities/tashahhud.dart';
import '../entities/tawba_entities/tawba.dart';
import '../entities/zkar_entities/zkar.dart';

abstract class BaseAzkerRepository {
  Future<Either<Failure, List<Azkar>>> getAllAzkar();
}

abstract class BaseZkerRepository {
  Future<Either<Failure, List<Zkar>>> getAllZkar();
}

abstract class BaseTawbaRepository {
  Future<Either<Failure, List<Tawba>>> getAllTawba();
}

abstract class BaseHajuRepository {
  Future<Either<Failure, List<Haju>>> getAllHaju();
}

abstract class BaseSaysRepository {
  Future<Either<Failure, List<Says>>> getAllSays();
}

abstract class BaseTashahhudRepository {
  Future<Either<Failure, List<Tashahhud>>> getAllTashahhud();
}
