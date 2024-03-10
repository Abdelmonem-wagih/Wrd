import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/features/location/domain/entities/location.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/app_string.dart';
import '../../../domain/usecase/location_usecase.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationServiceState> {
  final LocationUseCase locationUseCase;

  LocationCubit({required this.locationUseCase})
      : super(LocationLoadingState());

  Future<void> getLocation(double latitude, double longitude) async {
    emit(LocationLoadingState());
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      emit(OfflineLocation());
      return;
    }
    Either<Failure, List<Location>> response =
        await locationUseCase(LocationUseCaseParams(latitude: latitude , longitude: longitude));
    response.fold(
        (failure) =>
            emit(LocationErorrState(errorMessage: _mapFailureToMsg(failure))),
        (location) {
      emit(LocationSuccessState(location: location));
    });
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
