import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';

import '../../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/tashahhud_entities/tashahhud.dart';
import '../../../domain/use_case/azkar_usecase.dart';

part 'tashahhud_state.dart';

class TashahhudCubit extends Cubit<TashahhudState> {
  final TashahhudUseCase tashahhudUseCase;
  TashahhudCubit({
    required this.tashahhudUseCase,
  }) : super(TashahhudLoadingState());

  Future<void> getAllTashahhud() async {
    emit(TashahhudLoadingState());
    Either<Failure, List<Tashahhud>> response =
        await tashahhudUseCase(NoParams());
    debugPrint("goooooo $response");

    response.fold(
        (failure) =>
            emit(TashahhudErorrState(errorMessage: _mapFailureToMsg(failure))),
        (tashahhud) => emit(TashahhudSuccessState(tashahhud: tashahhud)));
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
