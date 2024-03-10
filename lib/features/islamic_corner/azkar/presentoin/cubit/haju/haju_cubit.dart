import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';
import '../../../domain/entities/haju_entities/haju.dart';

import '../../../../../../core/usecases/usecase.dart';
import '../../../domain/use_case/azkar_usecase.dart';

part 'haju_state.dart';

class HajuCubit extends Cubit<HajuState> {
  final HajuUseCase hajuUseCase;
  HajuCubit({
    required this.hajuUseCase,
  }) : super(HajuLoadingState());

  Future<void> getAllHaju() async {
    emit(HajuLoadingState());
    Either<Failure, List<Haju>> response = await hajuUseCase(NoParams());
    debugPrint("goooooo $response");

    response.fold(
        (failure) =>
            emit(HajuErorrState(errorMessage: _mapFailureToMsg(failure))),
        (haju) => emit(HajuSuccessState(haju: haju)));
  }

  String _mapFailureToMsg(Failure failure) {
    // ignore: unnecessary_type_check
    if (failure is Failure) {
      return failure.message;
    } else if (failure is ServerException) {
      return failure.message;
    } else {
      return 'An unknown error occurred';
    }
  }
}
