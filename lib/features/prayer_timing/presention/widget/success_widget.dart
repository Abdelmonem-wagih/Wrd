import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/features/prayer_timing/presention/bloc/timing/timing_state.dart';

import '../../../../core/bloc/timer/timer_bloc.dart';
import '../../../../core/controller/count_down_timer.dart';
import '../../../../core/controller/prayer.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constance.dart';
import '../../../prayer_times/presentoin/widgets/prayer_times_content/refresh_volume_calendar_direction.dart';
import '../../data/timing.dart';
import '../bloc/timing/timing_bloc.dart';
import '../controller/success_widget_controller.dart';
import '../controller/timing_controller.dart';

class SuccessWidget extends StatelessWidget {
  const SuccessWidget(this.timing, {super.key, required this.location, });

  final Timing timing;
  final String location;

  @override
  Widget build(BuildContext context) {
    final SuccessWidgetController controller =
        SuccessWidgetController(timing.data.timings, context);
    return Stack(
      children: [
        Positioned(
          bottom: 0.height,
          width: MediaQuery.of(context).size.width,
          child: const Image(
            image: AssetImage('assets/image/helf_down_frame.png'),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.height),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ContainerTitle(
                    day: timing.data.date.hijri.day,
                    monthOrWeekdayDay: timing.data.date.hijri.month.ar,
                  ),
                  Column(
                    children: [
                      const Prayers(
                        color: AppColors.darkTone,
                      ),
                      const SizedBox(height: 8),
                      BlocBuilder<TimingBloc, TimingState>(
                        builder: (context, state) {
                          TimingController? controller;
                          if (state is TimingLoaded) {
                            controller =
                                TimingController(state.timing.data.timings);
                          }
                          return AnimatedSwitcher(
                            duration: kAnimationDuration,
                            reverseDuration: Duration.zero,
                            switchInCurve: kAnimationCurve,
                            child: state is! TimingLoaded
                                ? Container()
                                : BlocProvider.value(
                                    value: TimerBloc(controller!.time),
                                    child: CountDownTimer(
                                      controller,
                                      color: AppColors.darkTone,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                  ContainerTitle(
                    day: timing.data.date.gregorian.day,
                    monthOrWeekdayDay: timing.data.date.hijri.weekday.ar,
                  ),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.width),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns in the grid
                    crossAxisSpacing: 20.0.width, // Spacing between columns
                    mainAxisSpacing: 20.0.height,
                    mainAxisExtent: 90.height,
                  ),
                  children: controller.generateTimingList(),
                ),
              ),
            ),
            RefreshVolumeCalendarDirection(
              isOffline: false,
              location: location,
            ),
          ],
        ),
      ],
    );
  }
}

class ContainerTitle extends StatelessWidget {
  const ContainerTitle({
    super.key,
    required this.day,
    required this.monthOrWeekdayDay,
  });
  final String monthOrWeekdayDay;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.width,
      height: 100.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.radius),
        color: AppColors.lightYellow,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              day,
              style: TextStyle(
                color:  AppColors.darkTone,
                fontWeight: FontWeight.w700,
                fontFamily: "Almarai",
                fontStyle:  FontStyle.normal,
                fontSize: 25.0.fontSize,
              ),
            ),
            Text(
              monthOrWeekdayDay,
              style: TextStyle(
                color:  AppColors.darkTone,
                fontWeight: FontWeight.w400,
                fontFamily: "Aldhabi",
                fontStyle:  FontStyle.normal,
                fontSize: 36.0.fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
