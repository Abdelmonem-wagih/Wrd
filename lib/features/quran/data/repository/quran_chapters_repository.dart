// ignore_for_file: public_member_api_docs, sort_constructors_first;
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/features/quran/data/data_source/quran_chapters_remote_data.dart';
import 'package:wrd/features/quran/domain/entities/quran_chapters.dart';
import 'package:wrd/features/quran/domain/repository/base_quran_chapters_repository.dart';


class QuranChaptersRepository extends BaseQuranChaptersRepository {
  final BaseQuranChaptersRemoteData baseQuranChaptersRemoteData;
  QuranChaptersRepository({
    required this.baseQuranChaptersRemoteData,
  });

  @override
  Future<Either<Failure, List<QuranChapters>>> getQuranChapters() async {
    final resultRemotData =
        await baseQuranChaptersRemoteData.getQuranChapters();
    try {
      return Right(resultRemotData);
    }  on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.errorMessageModel.message),
      );
    }
  }
}
