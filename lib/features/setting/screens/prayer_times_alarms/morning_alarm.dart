// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/features/setting/widgets/list_title_widget.dart';
import 'package:wrd/main.dart';

import '../../../../core/services/switch_helper.dart';
import '../../cubit/on_off_switch/on_off_azker_morning_cubit.dart';
import '../../../prayer_timing/data/timing.dart';
import '../../widgets/PrayerTimeAlarmsWidget/DhuhaAlarmWidget/list_title_dhuha_alarm.dart';
import '../../widgets/PrayerTimeAlarmsWidget/MorningAlarmWidget/list_title_morning_alarm.dart';

class MorningPrayerAlarm extends StatelessWidget {
  MorningPrayerAlarm({super.key, required this.prayerTime});

  final Timing prayerTime;

  bool valueSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            isArabic()
                ? Icons.arrow_back_ios_sharp
                : Icons.arrow_back_ios_new_sharp,
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: AppColors.primary,
          size: 20,
        ),
        title: const Text(
          'تذكير أذكار الصباح',
          style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontFamily: "Almarai",
              fontStyle: FontStyle.normal,
              fontSize: 20.0),
        ),
      ),
      body: BlocBuilder<OnOffAzkerMorningCubit, bool>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.darkTone,
                ),
                child: ListTitleWidget(
                  widget: GestureDetector(
                    onTap: () {
                      state = !state;
                      cancelRelatedReminders(
                        id: 1,
                        idsToCancel: [12, 13, 14, 15],
                      );
                      context
                          .read<OnOffAzkerMorningCubit>()
                          .switchOnOffAzkerMorning();
                    },
                    child: SwitchHelper(switchValue: state),
                  ),
                  leadingIcon: state == true
                      ? 'assets/svg/icon_voice_fill.svg'
                      : 'assets/svg/icon_oir_voice.svg',
                  text: 'أذكار الصباح',
                ),
              ),
              state == true
                  ? Container(
                      margin: const EdgeInsets.all(10),
                      //padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.darkTone,
                      ),
                      child: Column(
                        children: [
                          ListTitleMorningAlarm(
                            beforeAzanHelfHour: 30,
                            beforeAzanHour: 0,
                            id: 12,
                            title: 'تذكير بعد صلاة الفجر بنصف ساعة',
                            prayerTime: prayerTime.data.timings.fajr,
                            onOffMorningAlarmState: state,
                          ),
                          const Divider(
                            color: AppColors.white,
                            thickness: 0.5,
                          ),
                          ListTitleMorningAlarm(
                            beforeAzanHelfHour: 0,
                            beforeAzanHour: 1,
                            id: 13,
                            title: 'تذكير بعد صلاة الفجر بساعة',
                            prayerTime: prayerTime.data.timings.fajr,
                            onOffMorningAlarmState: state,
                          ),
                          const Divider(
                            color: AppColors.white,
                            thickness: 0.5,
                          ),
                          ListTitleMorningAlarm(
                            beforeAzanHelfHour: 0,
                            beforeAzanHour: 2,
                            id: 14,
                            title: 'تذكير بعد صلاة الفجر بساعتين',
                            prayerTime: prayerTime.data.timings.fajr,
                            onOffMorningAlarmState: state,
                          ),
                          const Divider(
                            color: AppColors.white,
                            thickness: 0.5,
                          ),
                          ListTitleMorningAlarm(
                            beforeAzanHelfHour: 0,
                            beforeAzanHour: 3,
                            id: 15,
                            title: 'تذكير بعد صلاة الفجر بثلاث ساعات',
                            prayerTime: prayerTime.data.timings.fajr,
                            onOffMorningAlarmState: state,
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }
}
