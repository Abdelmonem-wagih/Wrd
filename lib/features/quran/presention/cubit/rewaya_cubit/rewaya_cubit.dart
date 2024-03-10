import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/core/utils/app_string.dart';
import 'package:wrd/features/quran/domain/entities/quranAudio/rewaya.dart';
import 'package:wrd/features/quran/domain/use_case/rewayat_usecase.dart';

import '../../../../../core/usecases/usecase.dart';

part 'rewaya_state.dart';

class RewayaCubit extends Cubit<RewayaState> {
  final RewayaUseCase rewayaUseCase;
  RewayaCubit({
    required this.rewayaUseCase,
  }) : super(RewayaLoadingState());

  Future<void> getRewayat({int? rewaya}) async {
    emit(RewayaLoadingState());
    Either<Failure, List<Rewaya>> response = await rewayaUseCase(
      NoParams(),
    );
    debugPrint("goooooo $response");

    response.fold(
      (failure) => emit(
        RewayaErorrState(errorMessage: _mapFailureToMsg(failure)),
      ),
      (rewayat) => emit(
        RewayaSuccessState(rewayat: rewayat),
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
