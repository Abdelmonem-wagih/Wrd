import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';

import '../../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/azkar_entities/azkar.dart';
import '../../../domain/use_case/azkar_usecase.dart';

part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  final AzkarUseCase azkarUseCase;
  AzkarCubit({
    required this.azkarUseCase,
  }) : super(AzkarLoadingState());

  Future<void> getAllAzkar() async {
    emit(AzkarLoadingState());
    Either<Failure, List<Azkar>> response = await azkarUseCase(NoParams());
    debugPrint("goooooo $response");

    response.fold(
        (failure) =>
            emit(AzkarErorrState(errorMessage: _mapFailureToMsg(failure))),
        (azkar) => emit(AzkarSuccessState(azkar: azkar)));
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
