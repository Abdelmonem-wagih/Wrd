import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/tasbih.dart';
import '../../../domain/use_case/tasbih_usecase.dart';

part 'tasbih_state.dart';

class TasbihCubit extends Cubit<TasbihState> {
  final TasbihUseCase tasbihUseCase;
  TasbihCubit({
    required this.tasbihUseCase,
  }) : super(TasbihLoadingState());

  Future<void> getAllTasbih() async {
    emit(TasbihLoadingState());
    Either<Failure, List<Tasbih>> response = await tasbihUseCase(NoParams());
    debugPrint("goooooo $response");

    response.fold(
        (failure) =>
            emit(TasbihErorrState(errorMessage: _mapFailureToMsg(failure))),
        (tasbih) => emit(TasbihSuccessState(tasbih: tasbih)));
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
