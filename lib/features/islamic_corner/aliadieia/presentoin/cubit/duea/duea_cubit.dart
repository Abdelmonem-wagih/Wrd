import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';

import '../../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/duea.dart';
import '../../../domain/use_case/azkar_usecase.dart';

part 'duea_state.dart';

class DueaCubit extends Cubit<DueaState> {
  final DueaUseCase dueaUseCase;
  DueaCubit({
    required this.dueaUseCase,
  }) : super(DueaLoadingState());

  Future<void> getAllAliadieia() async {
    emit(DueaLoadingState());
    Either<Failure, List<Duea>> response = await dueaUseCase(NoParams());
    debugPrint("goooooo $response");

    response.fold(
        (failure) =>
            emit(DueaErorrState(errorMessage: _mapFailureToMsg(failure))),
        (duea) => emit(DueaSuccessState(duea: duea)));
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
