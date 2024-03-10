import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import '../../features/prayer_timing/presention/bloc/location/location_bloc.dart';
import '../../features/prayer_timing/presention/bloc/timing/timing_bloc.dart';
import '../../features/prayer_timing/presention/controller/timing_controller.dart';
import '../bloc/timer/timer_bloc.dart';
import '../utils/constance.dart';
import 'convert_duration_countdown.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer(this.controller, {super.key, required this.color});

  final TimingController controller;
  final Color color;
  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  late final Timer timer;

  bool isInit = false;
  @override
  void didChangeDependencies() {
    if (!isInit) {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) {
          if (BlocProvider.of<TimerBloc>(context).state is TimerLoaded &&
              BlocProvider.of<TimerBloc>(context).state.difference ==
                  Duration.zero) {
            if (widget.controller.timingCount == 5) {
              BlocProvider.of<TimingBloc>(context).requestTimingForTomorrow(
                BlocProvider.of<LocationBloc>(context).state,
              );
            } else {
              BlocProvider.of<TimingBloc>(context).updateTiming();
            }
          }
          BlocProvider.of<TimerBloc>(context).add(
            TimerTick(),
          );
        },
      );

      isInit = true;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: kAnimationDuration,
          reverseDuration: Duration.zero,
          switchInCurve: kAnimationCurve,
          child: state is! TimerLoaded
              ? Container()
              : Text(
                  convertDurationCountdown(state.difference),
                  style: TextStyle(
                    color: widget.color,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Almarai",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.0.fontSize,
                  ),
                ),
        );
      },
    );
  }
}
