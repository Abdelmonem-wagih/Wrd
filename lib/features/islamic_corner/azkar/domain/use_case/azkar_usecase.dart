import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/failure.dart';

import '../../../../../core/usecases/usecase.dart';
import '../entities/azkar_entities/azkar.dart';
import '../entities/haju_entities/haju.dart';
import '../entities/says_entities/says.dart';
import '../entities/tashahhud_entities/tashahhud.dart';
import '../entities/tawba_entities/tawba.dart';
import '../entities/zkar_entities/zkar.dart';
import '../repository/base_azkar_repository.dart';

class AzkarUseCase extends UseCase<List<Azkar>, NoParams> {
  final BaseAzkerRepository baseAzkerRepository;

  AzkarUseCase({required this.baseAzkerRepository});

  @override
  Future<Either<Failure, List<Azkar>>> call(NoParams params) async {
    return await baseAzkerRepository.getAllAzkar();
  }
}

class ZkarUseCase extends UseCase<List<Zkar>, NoParams> {
  final BaseZkerRepository baseZkerRepository;

  ZkarUseCase({required this.baseZkerRepository});

  @override
  Future<Either<Failure, List<Zkar>>> call(NoParams params) async {
    return await baseZkerRepository.getAllZkar();
  }
}

class TawbaUseCase extends UseCase<List<Tawba>, NoParams> {
  final BaseTawbaRepository baseTawbaRepository;

  TawbaUseCase({required this.baseTawbaRepository});

  @override
  Future<Either<Failure, List<Tawba>>> call(NoParams params) async {
    return await baseTawbaRepository.getAllTawba();
  }
}

class HajuUseCase extends UseCase<List<Haju>, NoParams> {
  final BaseHajuRepository baseHajuRepository;

  HajuUseCase({required this.baseHajuRepository});

  @override
  Future<Either<Failure, List<Haju>>> call(NoParams params) async {
    return await baseHajuRepository.getAllHaju();
  }
}

class SaysUseCase extends UseCase<List<Says>, NoParams> {
  final BaseSaysRepository baseSaysRepository;

  SaysUseCase({required this.baseSaysRepository});

  @override
  Future<Either<Failure, List<Says>>> call(NoParams params) async {
    return await baseSaysRepository.getAllSays();
  }
}

class TashahhudUseCase extends UseCase<List<Tashahhud>, NoParams> {
  final BaseTashahhudRepository baseTashahhudRepository;

  TashahhudUseCase({required this.baseTashahhudRepository});

  @override
  Future<Either<Failure, List<Tashahhud>>> call(NoParams params) async {
    return await baseTashahhudRepository.getAllTashahhud();
  }
}
