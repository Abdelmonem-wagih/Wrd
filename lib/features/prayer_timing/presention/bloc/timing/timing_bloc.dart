import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:wrd/features/prayer_timing/presention/bloc/location/location_state.dart';
import '../../../data/timing.dart';
import '../../controller/timing_controller.dart';
import 'timing_state.dart';


class TimingBloc extends Cubit<TimingState> {
  Timing? _timing;

  TimingBloc() : super(TimingInitial());

  void requestTiming(LocationState locationState) async {
    debugPrint('//////////////////////// LocationInitial /////////////////////////////////');

    if (_timing != null) {
      debugPrint('//////////////////////// LocationInitial /////////////////////////////////');

      final controller = TimingController(_timing!.data.timings);
      emit(
        PrayerLoadedState(
          showPrayerText: controller.showPrayerText,
          currentPrayerTime: controller.prayer,
        ),
      );
    }

    var randomNumber = Random().nextInt(286) + 1;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      emit(OfflineData());
      return;
    }

    emit(TimingLoading());

    if ((locationState is LocationSuccess)) {
      Timing result = await getPrayerTiming(
        locationState.latitude,
        locationState.longitude,
      );
      emit(TimingLoaded(result, randomNumber));
    } else {
      emit(TimingFailed(locationState.failure));
    }
  }

  void requestTimingForTomorrow(LocationState locationState) async {
    emit(TimingLoading());

    if (locationState is LocationFailed) {
      emit(TimingFailed(locationState.failure!));
      return;
    }

    var result = await getPrayerTiming(
      locationState.latitude,
      locationState.longitude,
      forTomorrow: true,
    );

    result.fold((l) async {
      emit(TimingFailed(l));
    }, (r) async {
      _timing = r;
      emit(TimingLoaded(r, Random().nextInt(286) + 1));
    });
  }

  void updateTiming() {
    if (_timing != null) {
      final Timing timing = Timing(
        code: _timing!.code,
        data: _timing!.data,
        status: _timing!.status,
      );

      emit(TimingLoaded(timing, Random().nextInt(286) + 1));
    }
  }
}
