import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/widget/loading_widget.dart';
import 'package:wrd/features/prayer_timing/presention/bloc/location/location_state.dart';
import '../features/prayer_timing/presention/bloc/timing/timing_bloc.dart';

import '../features/prayer_timing/presention/bloc/timing/timing_state.dart';
import 'home_widget.dart';

class TabScaffold extends StatelessWidget {
  final double? locationLong;
  final double? locationLite;
  final bool isOffline;
  final LocationState? locationState;
  final String? locationDetails;
  const TabScaffold({
    super.key,
    this.isOffline = false,
    this.locationLong,
    this.locationLite,
    this.locationState,
     this.locationDetails,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('<<<<<<<<<<<<=== inSide TabScaffold ===>>>>>>>>>>>>>');
    context.read<TimingBloc>().requestTiming(locationState!);
    print('locationDetails=>>>>>>>>>>>>>>>>>>>>> $locationDetails');

    return BlocBuilder<TimingBloc, TimingState>(builder: (context, state) {
      if (state is TimingLoaded) {
        debugPrint('<<<<<<<<<<<<=== inSide TimingLoaded ===>>>>>>>>>>>>>');
        debugPrint('Random Number: ${state.randomNumber}');

        return HomeWidget(
          ayaNumber: state.randomNumber,
          locationLong: locationLong,
          locationLait: locationLite,
          timing: state.timing,
          locationDetails: locationDetails,
        );
      } else if (state is OfflineData) {
        return const HomeWidget(
          ayaNumber: 1,
          isOffline: true,
        );
      } else if (state is TimingFailed) {
        return Scaffold(
          body: Center(
            child: AlertDialog(
              title: const Text('Timing Error'),
              content:
                  Text('Failed to fetch timing: ${state.failure!.message}'),
            ),
          ),
        );
      } else {
        return const Scaffold(
          body: Center(
            child: LoadingWidget(),
          ),
        );
      }
    });
  }
}
