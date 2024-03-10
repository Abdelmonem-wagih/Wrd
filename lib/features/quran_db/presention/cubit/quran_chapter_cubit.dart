import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/app_string.dart';
import '../../domain/entities/quran_chapter.dart';
import '../../domain/usecase/quran_chapter_usecase.dart';

part 'quran_chapter_state.dart';

class QuranChapterCubit extends Cubit<QuranChapterState> {
  final QuranChapterUseCase quranChapterUseCase;

  QuranChapterCubit({
    required this.quranChapterUseCase,
  }) : super(QuranChapterLoadingState());

  Future<void> fetchQuranChapters() async {
    emit(QuranChapterLoadingState());
    Either<Failure, List<QuranChapter>> response =
        await quranChapterUseCase(NoParams());
    debugPrint("goooooo $response");

    response.fold(
        (failure) => emit(
            QuranChapterErorrState(errorMessage: _mapFailureToMsg(failure))),
        (quranChapter) =>
            emit(QuranChapterSuccessState(quranChapter: quranChapter)));
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
