// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/core/usecases/usecase.dart';
import 'package:wrd/features/quran/domain/entities/quran_chapters.dart';
import 'package:wrd/features/quran/domain/repository/base_quran_chapters_repository.dart';

class QuranChaptersUseCase extends UseCase<List<QuranChapters>, NoParams> {
  final BaseQuranChaptersRepository baseQuranChaptersRepository ;
  QuranChaptersUseCase({
    required this.baseQuranChaptersRepository,
  });
  @override
  Future<Either<Failure, List<QuranChapters>>> call(NoParams params) async {
    return await baseQuranChaptersRepository.getQuranChapters();
  }
}
