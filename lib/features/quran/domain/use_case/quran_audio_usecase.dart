// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/core/usecases/usecase.dart';
import 'package:wrd/features/quran/domain/entities/quranAudio/quran_audio.dart';
import 'package:wrd/features/quran/domain/repository/base_quran_audio_repository.dart';

class QuranAudioUseCase extends UseCase<List<QuranAudio>, NoParams> {
  final BaseQuranAudioRepository baseQuranAudioRepository;
  QuranAudioUseCase({
    required this.baseQuranAudioRepository,
  });
  @override
  Future<Either<Failure, List<QuranAudio>>> call(
    NoParams params, {
    int? rewaya,
  }) async {
    return await baseQuranAudioRepository.getQuranAudio(rewaya: rewaya);
  }
}
