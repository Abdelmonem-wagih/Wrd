// ignore_for_file: public_member_api_docs, sort_constructors_first;
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';

import '../../domain/entities/quran_chapter.dart';
import '../../domain/repository/base_quran_chapter_repo.dart';
import '../data_source/quran_chapter_remote_data.dart';

class QuranChapterRepository extends BaseQuranChapterRepository {
  final BaseQuranChapterRemoteData baseQuranChapterRemoteData;
  QuranChapterRepository({
    required this.baseQuranChapterRemoteData,
  });

  @override
  Future<Either<Failure, List<QuranChapter>>> fetchQuranChapters() async {
    final resultRemotData =
        await baseQuranChapterRemoteData.fetchQuranChapters();
    try {
      return Right(resultRemotData);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.errorMessageModel.message),
      );
    }
  }
}
