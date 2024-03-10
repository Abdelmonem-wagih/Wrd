import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/failure.dart';

import '../entities/quranAudio/quran_audio.dart';

abstract class BaseQuranAudioRepository {
  Future<Either<Failure, List<QuranAudio>>> getQuranAudio({int? rewaya});
}
