// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/core/usecases/usecase.dart';

import '../entities/quran_chapter.dart';
import '../repository/base_quran_chapter_repo.dart';

class QuranChapterUseCase extends UseCase<List<QuranChapter>, NoParams> {
  final BaseQuranChapterRepository baseQuranChapterRepository;
  QuranChapterUseCase({
    required this.baseQuranChapterRepository,
  });
  @override
  Future<Either<Failure, List<QuranChapter>>> call(NoParams params) async {
    return await baseQuranChapterRepository.fetchQuranChapters();
  }
}
