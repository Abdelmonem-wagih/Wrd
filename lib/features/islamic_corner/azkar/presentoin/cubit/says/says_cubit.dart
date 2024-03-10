import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';

import '../../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/says_entities/says.dart';
import '../../../domain/use_case/azkar_usecase.dart';

part 'says_state.dart';

class SaysCubit extends Cubit<SaysState> {
  final SaysUseCase saysUseCase;
  SaysCubit({
    required this.saysUseCase,
  }) : super(SaysLoadingState());

  Future<void> getAllSays() async {
    emit(SaysLoadingState());
    Either<Failure, List<Says>> response = await saysUseCase(NoParams());
    debugPrint("goooooo $response");

    response.fold(
        (failure) =>
            emit(SaysErorrState(errorMessage: _mapFailureToMsg(failure))),
        (says) => emit(SaysSuccessState(says: says)));
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
