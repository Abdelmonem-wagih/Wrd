import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/failure.dart';

import '../entities/quran_chapters.dart';

abstract class BaseQuranChaptersRepository {
  Future<Either<Failure, List<QuranChapters>>> getQuranChapters();
}
