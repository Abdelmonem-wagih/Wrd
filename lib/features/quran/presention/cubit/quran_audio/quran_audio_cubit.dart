import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/core/utils/app_string.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/quranAudio/quran_audio.dart';
import '../../../domain/use_case/quran_audio_usecase.dart';

part 'quran_audio_state.dart';

class QuranAudioCubit extends Cubit<QuranAudioState> {
  final QuranAudioUseCase quranAudioUseCase;
  QuranAudioCubit({required this.quranAudioUseCase})
      : super(QuranAudioLoadingState());

  Future<void> getQuranAudio({int? rewaya}) async {
    emit(QuranAudioLoadingState());
    Either<Failure, List<QuranAudio>> response =
        await quranAudioUseCase(NoParams(), rewaya: rewaya);
    debugPrint("goooooo $response");

    response.fold(
      (failure) => emit(
        QuranAudioErorrState(errorMessage: _mapFailureToMsg(failure)),
      ),
      (quranAudio) => emit(
        QuranAudioSuccessState(quranAudio: quranAudio),
      ),
    );
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppString.serverFailure;
      case CacheFailure:
        return AppString.cacheFailure;

      default:
        return AppString.unexpectedError;
    }
  }
}
