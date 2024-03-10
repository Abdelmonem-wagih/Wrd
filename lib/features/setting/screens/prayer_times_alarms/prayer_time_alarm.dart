import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/features/prayer_timing/data/timing.dart';
import 'package:wrd/features/setting/widgets/list_title_widget.dart';
import 'package:wrd/features/setting/widgets/PrayerTimeAlarmsWidget/switch_icon.dart';
import 'package:wrd/main.dart';

import '../../../../core/bloc/true_false/boolCubit.dart';
import '../../cubit/on_off_switch/on_off_prayertime_cubit.dart';
import 'controll_prayer.dart';
import 'dhuhr_prayer_alarm.dart';
import 'evening_alarm.dart';
import 'morning_alarm.dart';

class PrayerTimeAlarm extends StatelessWidget {
  const PrayerTimeAlarm({super.key, required this.timing});
  final Timing timing;

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
          'منبه الأذكار والأذان',
          style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontFamily: "Almarai",
              fontStyle: FontStyle.normal,
              fontSize: 20.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              BlocBuilder<OnOffPrayerTimeCubit, bool>(
                builder: (context, onOffPrayerTimeState) {
                  return onOffPrayerTimeState == true
                      ? BlocBuilder<NumberCubit, int>(
                          builder: (context, stateNumber) {
                            return Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.darkTone,
                                ),
                                child: BlocProvider(
                                  create: (context) => SwitchPrayerCubit(),
                                  child: BlocBuilder<SwitchPrayerCubit,
                                      Map<int, bool>>(
                                    builder: (context, state) {
                                      return Column(
                                        children: [
                                          ListTitleWidget(
                                            widget: SwitchIcon(
                                              stateNumber: stateNumber,
                                              onOffPrayerTimeSwitch:
                                                  onOffPrayerTimeState,
                                              prayerTimeName: 'الفجْر',
                                              prayerTime:
                                                  timing.data.timings.fajr,
                                              id: 1,
                                            ),
                                            leadingIcon: state[1] == true
                                                ? 'assets/svg/icon_voice_fill.svg'
                                                : 'assets/svg/icon_oir_voice.svg',
                                            text: 'الفجْر',
                                          ),
                                          ListTitleWidget(
                                            widget: SwitchIcon(
                                              stateNumber: stateNumber,
                                              onOffPrayerTimeSwitch:
                                                  onOffPrayerTimeState,
                                              prayerTimeName: 'الشروق',
                                              prayerTime:
                                                  timing.data.timings.sunrise,
                                              id: 2,
                                            ),
                                            leadingIcon: state[2] == true
                                                ? 'assets/svg/icon_voice_fill.svg'
                                                : 'assets/svg/icon_oir_voice.svg',
                                            text: 'الشروق',
                                          ),
                                          ListTitleWidget(
                                            widget: SwitchIcon(
                                              stateNumber: stateNumber,
                                              onOffPrayerTimeSwitch:
                                                  onOffPrayerTimeState,
                                              prayerTimeName: 'الظُّهْر',
                                              prayerTime:
                                                  timing.data.timings.dhuhr,
                                              id: 3,
                                            ),
                                            leadingIcon: state[3] == true
                                                ? 'assets/svg/icon_voice_fill.svg'
                                                : 'assets/svg/icon_oir_voice.svg',
                                            text: 'الظُّهْر',
                                          ),
                                          ListTitleWidget(
                                            widget: SwitchIcon(
                                              stateNumber: stateNumber,
                                              onOffPrayerTimeSwitch:
                                                  onOffPrayerTimeState,
                                              prayerTimeName: 'العَصر',
                                              prayerTime:
                                                  timing.data.timings.asr,
                                              id: 4,
                                            ),
                                            leadingIcon: state[4] == true
                                                ? 'assets/svg/icon_voice_fill.svg'
                                                : 'assets/svg/icon_oir_voice.svg',
                                            text: 'العَصر',
                                          ),
                                          ListTitleWidget(
                                            widget: SwitchIcon(
                                              stateNumber: stateNumber,
                                              onOffPrayerTimeSwitch:
                                                  onOffPrayerTimeState,
                                              prayerTimeName: 'المَغرب',
                                              prayerTime:
                                                  timing.data.timings.maghrib,
                                              id: 5,
                                            ),
                                            leadingIcon: state[5] == true
                                                ? 'assets/svg/icon_voice_fill.svg'
                                                : 'assets/svg/icon_oir_voice.svg',
                                            text: 'المَغرب',
                                          ),
                                          ListTitleWidget(
                                            widget: SwitchIcon(
                                              stateNumber: stateNumber,
                                              onOffPrayerTimeSwitch:
                                                  onOffPrayerTimeState,
                                              prayerTimeName: 'العِشاء',
                                              prayerTime:
                                                  timing.data.timings.isha,
                                              id: 6,
                                            ),
                                            leadingIcon: state[6] == true
                                                ? 'assets/svg/icon_voice_fill.svg'
                                                : 'assets/svg/icon_oir_voice.svg',
                                            text: 'العِشاء',
                                          ),
                                          ListTitleWidget(
                                            widget: SwitchIcon(
                                              stateNumber: stateNumber,
                                              onOffPrayerTimeSwitch:
                                                  onOffPrayerTimeState,
                                              prayerTimeName:
                                                  'الثلث الأخير من الليل',
                                              prayerTime:
                                                  timing.data.timings.lastthird,
                                              id: 7,
                                            ),
                                            leadingIcon: state[7] == true
                                                ? 'assets/svg/icon_voice_fill.svg'
                                                : 'assets/svg/icon_oir_voice.svg',
                                            text: 'الثلث الأخير من الليل',
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ));
                          },
                        )
                      : Container();
                },
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.darkTone,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DhuhPrayerAlarm(
                          prayerTime: timing,
                        ),
                      )),
                      child: const ListTitleWidget(
                        trailingIcon: Icons.arrow_back_ios_new_sharp,
                        text: 'صلاة الضحي',
                      ),
                    ),
                    const Divider(
                      color: AppColors.white,
                      thickness: 0.5,
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MorningPrayerAlarm(
                          prayerTime: timing,
                        ),
                      )),
                      child: const ListTitleWidget(
                        trailingIcon: Icons.arrow_back_ios_new_sharp,
                        text: 'أذكار الصباح',
                      ),
                    ),
                    const Divider(
                      color: AppColors.white,
                      thickness: 0.5,
                    ), //EveningAlarm
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EveningAlarm(
                          prayerTime: timing,
                        ),
                      )),
                      child: const ListTitleWidget(
                        trailingIcon: Icons.arrow_back_ios_new_sharp,
                        text: 'أذكار المساء',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.darkTone,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ControllPrayer(),
                        ),
                      ),
                      child: const ListTitleWidget(
                        trailingIcon: Icons.arrow_back_ios_new_sharp,
                        text: 'التحكم في الأذان',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
