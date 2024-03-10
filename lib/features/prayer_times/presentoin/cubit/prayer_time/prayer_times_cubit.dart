// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:wrd/core/usecases/usecase.dart';
import 'package:wrd/core/utils/app_string.dart';
import 'package:wrd/features/prayer_times/domain/entities/prayer_times/prayer_times.dart';
import 'package:wrd/features/prayer_times/domain/use_case/prayer_times_use_case.dart';

import '../../../../../core/error/failure.dart';

part 'prayer_times_state.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  final PrayerTimesUseCase prayerTimesUseCase;
  

  PrayerTimesCubit({required this.prayerTimesUseCase})
      : super(PrayerTimesLoadingState());

  Future<void> getPrayerTimes() async {
    emit(PrayerTimesLoadingState());
    Either<Failure, List<PrayerTime>> response =
        await prayerTimesUseCase(NoParams());
    debugPrint("goooooo $response");

    response.fold(
        (failure) => emit(
            PrayerTimesErorrState(errorMessage: _mapFailureToMsg(failure))),
        (prayerTimes) {
      emit(PrayerTimesSuccessState(prayerTimes: prayerTimes));
    });

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
