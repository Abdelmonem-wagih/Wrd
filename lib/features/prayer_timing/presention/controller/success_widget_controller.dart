import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/function.dart';
import '../../../../core/utils/remove_am_pm.dart';
import '../../../setting/cubit/controller/control_adhan_asr_timing.dart';
import '../../data/timing.dart';
import 'timing_controller.dart';

enum TimingProps {
  Fajr,
  Dhuhr,
  Asr,
  Maghrib,
  Isha,
}

Map<TimingProps, String> backgroundAsset = {
  TimingProps.Fajr: 'assets/image/background_fagr.png',
  TimingProps.Dhuhr: 'assets/image/icon_dohr.png',
  TimingProps.Asr: 'assets/image/icon_asr.png',
  TimingProps.Maghrib: 'assets/image/icon_mghrb.png',
  TimingProps.Isha: 'assets/image/icon_eshaa.png',
};

class SuccessWidgetController {
  final Timings? timings;
  final BuildContext context;
  late final int timingCount;
  late final int timingCalenderCount;
  late final List<Map<String, String>> timingsList;
  late final List<Map<String, String>> timingsListCalender;

  SuccessWidgetController(this.timings, this.context) {
    final controller = TimingController(timings!);
    timingCount = controller.timingCount;
    timingCalenderCount = controller.timingCalenderCount;

    timingsList = controller.timingsList;
    timingsListCalender = controller.timingsListCalender;
  }

  String setBackgroundImage() {
    switch (timingCount) {
      case 0:
        return backgroundAsset[TimingProps.Fajr]!;
      case 1:
        return backgroundAsset[TimingProps.Dhuhr]!;
      case 2:
        return backgroundAsset[TimingProps.Asr]!;
      case 3:
        return backgroundAsset[TimingProps.Maghrib]!;
      case 4:
        return backgroundAsset[TimingProps.Isha]!;
      default:
        return backgroundAsset[TimingProps.Fajr]!;
    }
  }

  List<Widget> generateCalender() {
    return List.generate(
      timingsListCalender.length,
      (index) => Container(
        decoration: index == timingCalenderCount
            ? const BoxDecoration(
                color: AppColors.second,
              )
            : const BoxDecoration(
                color: Color(0xffecd8bf),
              ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              timingsListCalender[index].entries.first.key,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontFamily: "Almarai",
                fontStyle: FontStyle.normal,
                fontSize: 14.0,
              ),
            ),
            Text(
              updateTime(timingsListCalender[index].entries.first.value),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontFamily: "Almarai",
                fontStyle: FontStyle.normal,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> generateTimingList() {
    return List.generate(timingsList.length, (index) {
      final String prayerTimeName = timingsList[index].entries.first.key;
      final String prayerTime =
          removeAmPm(timingsList[index].entries.first.value);
      return Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(
            8.radius,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              prayerTimeName,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontFamily: "Almarai",
                fontStyle: FontStyle.normal,
                fontSize: 20.0.fontSize,
              ),
            ),
            BlocBuilder<ControlAdhanAsrTimingCubit, String>(
              builder: (context, state) {
                return state == 'حنفي' && prayerTimeName == 'العصــر'
                    ? Text(
                        '${int.parse(prayerTime.split(':')[0]) > 10 ? int.parse(prayerTime.split(':')[0]):'0'''
                            '${int.parse(prayerTime.split(':')[0])}'}:'
                        '${int.parse(prayerTime.split(':')[1]) + 4 > 10 ? int.parse(prayerTime.split(':')[1]) + 4 : '0'
                            '${int.parse(prayerTime.split(':')[1]) + 4}'}',
                        style: TextStyle(
                          height: 1.5.height,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Almarai",
                          fontStyle: FontStyle.normal,
                          fontSize: 18.0.fontSize,
                        ),
                      )
                    : Text(
                        prayerTime,
                        style: TextStyle(
                          height: 1.5.height,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Almarai",
                          fontStyle: FontStyle.normal,
                          fontSize: 18.0.fontSize,
                        ),
                      );
              },
            ),
            // BlocBuilder<TimeFormatBloc, TimeFormatState>(
            //   builder: (context, state) {
            //     return Text(
            //       state.is24
            //           ? timingsList[index].entries.first.value
            //           : convertTimeTo12HourFormat(
            //               timingsList[index].entries.first.value),
            //       textAlign: TextAlign.center,
            //       style: Theme.of(context).textTheme.titleLarge!.copyWith(
            //             color: Colors.white,
            //           ),
            //     );
            //   },
            // )
          ],
        ),
      );
    });
  }
}
