// ignore_for_file: public_member_api_docs, sort_constructors_first;
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/features/quran/data/data_source/quran_audio_remote_data.dart';
import 'package:wrd/features/quran/domain/repository/base_quran_audio_repository.dart';

import '../model/quranAudio/quran_audio_model.dart';

class QuranAudioRepository extends BaseQuranAudioRepository {
  final BaseQuranAudioRemoteData baseQuranAudioRemoteData;
  QuranAudioRepository({
    required this.baseQuranAudioRemoteData,
  });

  @override
  Future<Either<Failure, List<QuranAudioModel>>> getQuranAudio({
    int? rewaya,
  }) async {
    final resultRemotData = await baseQuranAudioRemoteData.getQuranAudio(
      rewaya: rewaya,
    );
    try {
      debugPrint('Right(resultRemotData)${Right(resultRemotData)}');
      return Right(resultRemotData);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.errorMessageModel.message),
      );
    }
  }
}
