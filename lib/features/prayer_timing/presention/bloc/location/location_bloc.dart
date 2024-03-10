import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/failuer.dart';
import '../../controller/location/location_controller.dart';
import 'location_state.dart';

class LocationBloc extends Cubit<LocationState> {

  LocationBloc()
      : super(const LocationInitial(
          91,
          181,
          LocalFailure(
            error: 0,
            message: 'initializing',
          ),
        ));

  Future<void> initLocation() async {
    debugPrint('//////////////////////// LocationInitial /////////////////////////////////');

    emit(LocationLoading(state.latitude, state.longitude));
    debugPrint('//////////////////////// LocationLoading /////////////////////////////////');

    debugPrint('latitude ${state.latitude} ///////longitude ${state.longitude} /////////////////////////////////');
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      emit(OfflineState(state.latitude, state.longitude));
      return;
    }
    final result = await getCurrentPosition();
    debugPrint('result//////////////////////// $result /////////////////////////////////');

    result.fold(
      (l) => emit(LocationFailed(state.latitude, state.longitude, l)),
      (r) async {
        emit(LocationSuccess(r.latitude, r.longitude));
      },
    );
  }
}
