// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wrd/features/prayer_timing/presention/bloc/timing/timing_state.dart';
import '../../features/prayer_timing/presention/bloc/timing/timing_bloc.dart';
import '../../features/prayer_timing/presention/controller/timing_controller.dart';
import '../utils/constance.dart';

class Prayers extends StatelessWidget {
  const Prayers({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimingBloc, TimingState>(
      builder: (context, state) {
        TimingController? controller;

        if (state is TimingLoaded)
          controller = TimingController(state.timing.data.timings);
        return AnimatedSwitcher(
          duration: kAnimationDuration,
          reverseDuration: Duration.zero,
          switchInCurve: kAnimationCurve,
          child: state is! TimingLoaded
              ? const Row(
                  children: [
                    Text(
                      'No Internet connection',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Almarai",
                        fontStyle: FontStyle.normal,
                        fontSize: 10.0,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.network_check,
                      color: Colors.white,
                      size: 15,
                    ),
                  ],
                )
              : Row(
                  children: [
                    Text(
                      controller!.prayer,
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Almarai",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      controller.time,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Almarai",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
