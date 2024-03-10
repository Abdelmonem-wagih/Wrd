import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/loading_widget.dart';
import '../../../../core/widget/no_internet_widget.dart';
import '../bloc/location/location_bloc.dart';
import '../bloc/location/location_state.dart';
import '../widget/timing_screen_scaffold.dart';

class PrayerTimingScreen extends StatelessWidget {
  const PrayerTimingScreen(
      {super.key, this.isOffline = false,  this.location,});
  final bool isOffline;
  final String? location;

  @override
  Widget build(BuildContext context) {
    return isOffline == true
        ? const NoInternetWidget()
        : BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              if (state is LocationLoading) {
                return const Scaffold(
                  body: LoadingWidget(),
                );
              }
              return TimingScreenScaffold(
                location: location!,
              );
            },
          );
  }
}
