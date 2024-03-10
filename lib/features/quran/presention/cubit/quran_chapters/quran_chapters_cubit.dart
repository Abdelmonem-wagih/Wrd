// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/core/utils/app_string.dart';
import 'package:wrd/features/quran/domain/entities/quran_chapters.dart';
import 'package:wrd/features/quran/domain/use_case/quran_chapters_usecase.dart';

import '../../../../../core/usecases/usecase.dart';

part 'quran_chapters_state.dart';

class QuranChaptersCubit extends Cubit<QuranChaptersState> {
  final QuranChaptersUseCase quranChaptersUseCase;

  QuranChaptersCubit({
    required this.quranChaptersUseCase,
  }) : super(QuranChaptersLoadingState());

  Future<void> getQuranChapters() async {
    emit(QuranChaptersLoadingState());
    Either<Failure, List<QuranChapters>> response =
        await quranChaptersUseCase(NoParams());
    debugPrint("goooooo $response");

    response.fold(
      (failure) => emit(
          QuranChaptersErorrState(errorMessage: _mapFailureToMsg(failure))),
      (quranChapters) => emit(
        QuranChaptersSuccessState(quranChapters: quranChapters),
      ),
    );

    /* emit(PrayerTimesLoadingState());
    try {
      final response = await PrayerTimesRemoteData().getAllPrayerTimes();
      debugPrint(response);
      emit(PrayerTimesSuccessState(response));
    } on Exception catch (error) {
      emit(PrayerTimesErorrState(error.toString()));
    }*/
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
