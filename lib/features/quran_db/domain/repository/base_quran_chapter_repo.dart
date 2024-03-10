import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/failure.dart';
import '../entities/quran_chapter.dart';

abstract  class  BaseQuranChapterRepository{
  Future<Either<Failure,List<QuranChapter>>> fetchQuranChapters();
}