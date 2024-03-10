import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wrd/core/widget/loading_widget.dart';

import 'package:wrd/test_screen/tab_scaffold.dart';

import '../features/location/presention/cubit/location/location_cubit.dart';
import '../features/prayer_timing/presention/bloc/location/location_bloc.dart';
import '../features/prayer_timing/presention/bloc/location/location_state.dart';

class TabScreen extends StatelessWidget {
  const TabScreen._internal();

  static const TabScreen instance = TabScreen._internal();

  factory TabScreen() => instance;

  @override
  Widget build(BuildContext context) {
    final locationCubit = context.read<LocationCubit>();
    BlocProvider.of<LocationBloc>(context).initLocation();

    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is LocationLoading) {
          return const Scaffold(
            body: Center(
              child: LoadingWidget(),
            ),
          );
        } else if (state is LocationSuccess) {
          locationCubit.getLocation(state.latitude, state.longitude);
          return BlocBuilder<LocationCubit, LocationServiceState>(
            builder: (context, stateLocation) {
              if (stateLocation is LocationSuccessState) {
                return TabScaffold(
                  locationLong: state.longitude,
                  locationLite: state.latitude,
                  locationState: state,
                  locationDetails: stateLocation.location[0].displayName,
                );
              } else if (stateLocation is LocationErorrState) {
                return Scaffold(
                  body: Center(
                    child: AlertDialog(
                      title: Text('Location Error'),
                      content: Text(
                          ' can not fetch Location${stateLocation.errorMessage}'),
                    ),
                  ),
                );
              }
              return const Scaffold(
                body: Center(
                  child: LoadingWidget(),
                ),
              );
            },
          );
        } else if (state is LocationFailed) {
          return Scaffold(
            body: Center(
              child: AlertDialog(
                title: Text('Location Error'),
                content:
                    Text('Failed to fetch Location: ${state.failure!.message}'),
              ),
            ),
          );
        } else if (state is OfflineState) {
          return TabScaffold(
          isOffline: true,
            locationState: state,
          );
        } else {
          return const Scaffold(
            body: Center(
              child: LoadingWidget(),
            ),
          );
        }
      },
    );
  }
}
