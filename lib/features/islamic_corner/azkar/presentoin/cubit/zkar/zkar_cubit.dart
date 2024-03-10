import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';

import '../../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/zkar_entities/zkar.dart';
import '../../../domain/use_case/azkar_usecase.dart';

part 'zkar_state.dart';

class ZkarCubit extends Cubit<ZkarState> {
  final ZkarUseCase zkarUseCase;
  ZkarCubit({
    required this.zkarUseCase,
  }) : super(ZkarLoadingState());

  Future<void> getAllZkar() async {
    emit(ZkarLoadingState());
    Either<Failure, List<Zkar>> response = await zkarUseCase(NoParams());
    debugPrint("goooooo $response");

    response.fold(
        (failure) =>
            emit(ZkarErorrState(errorMessage: _mapFailureToMsg(failure))),
        (zkar) => emit(ZkarSuccessState(zkar: zkar)));
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
