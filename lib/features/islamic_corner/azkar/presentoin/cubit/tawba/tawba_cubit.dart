import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';

import '../../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/tawba_entities/tawba.dart';
import '../../../domain/use_case/azkar_usecase.dart';

part 'tawba_state.dart';

class TawbaCubit extends Cubit<TawbaState> {
  final TawbaUseCase tawbaUseCase;
  TawbaCubit({
    required this.tawbaUseCase,
  }) : super(TawbaLoadingState());

  Future<void> getAllTawba() async {
    emit(TawbaLoadingState());
    Either<Failure, List<Tawba>> response = await tawbaUseCase(NoParams());
    debugPrint("goooooo $response");

    response.fold(
        (failure) =>
            emit(TawbaErorrState(errorMessage: _mapFailureToMsg(failure))),
        (tawba) => emit(TawbaSuccessState(tawba: tawba)));
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
