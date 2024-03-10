import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/features/quran/domain/entities/quranAudio/rewaya.dart';

abstract class BaseRewayaRepository {
  Future<Either<Failure, List<Rewaya>>> getRewayat();
}
