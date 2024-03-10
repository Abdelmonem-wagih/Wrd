import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/features/setting/widgets/list_title_widget.dart';
import 'package:wrd/main.dart';

import '../../../../core/services/switch_helper.dart';
import '../../cubit/on_off_switch/on_off_azker_evening_cubit.dart';
import '../../../prayer_timing/data/timing.dart';
import '../../widgets/PrayerTimeAlarmsWidget/DhuhaAlarmWidget/list_title_dhuha_alarm.dart';
import '../../widgets/PrayerTimeAlarmsWidget/EveningAlarmWidget/list_title_evening_alarm.dart';

class EveningAlarm extends StatefulWidget {
  const EveningAlarm({super.key, required this.prayerTime});

  final Timing prayerTime;

  @override
  State<EveningAlarm> createState() => _EveningAlarmState();
}

class _EveningAlarmState extends State<EveningAlarm> {
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
          'تذكير أذكار المساء',
          style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontFamily: "Almarai",
              fontStyle: FontStyle.normal,
              fontSize: 20.0),
        ),
      ),
      body: BlocBuilder<OnOffAzkerEveningCubit, bool>(
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
                        idsToCancel: [16, 17, 18, 19],
                      );
                      context
                          .read<OnOffAzkerEveningCubit>()
                          .switchOnOffAzkerEvening();
                    },
                    child: SwitchHelper(switchValue: state),
       ),
                  leadingIcon: state == true
                      ? 'assets/svg/icon_voice_fill.svg'
                      : 'assets/svg/icon_oir_voice.svg',
                  text: 'أذكار المساء',
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
                          ListTitleEveningAlarm(
                            beforeAzanHelfHour: 30,
                            beforeAzanHour: 0,
                            id: 16,
                            title: 'تذكير بعد صلاة العصر بنصف ساعة',
                            prayerTime: widget.prayerTime.data.timings.asr,
                            onOffEveningAlarmState: state,
                          ),
                          const Divider(
                            color: AppColors.white,
                            thickness: 0.5,
                          ),
                          ListTitleEveningAlarm(
                            beforeAzanHelfHour: 0,
                            beforeAzanHour: 1,
                            id: 17,
                            title: 'تذكير بعد صلاة العصر بساعة',
                            prayerTime: widget.prayerTime.data.timings.asr,
                            onOffEveningAlarmState: state,
                          ),
                          const Divider(
                            color: AppColors.white,
                            thickness: 0.5,
                          ),
                          ListTitleEveningAlarm(
                            beforeAzanHelfHour: 30,
                            beforeAzanHour: 1,
                            id: 18,
                            title: 'تذكير بعد صلاة العصر بساعه ونصف',
                            prayerTime: widget.prayerTime.data.timings.asr,
                            onOffEveningAlarmState: state,
                          ),
                          const Divider(
                            color: AppColors.white,
                            thickness: 0.5,
                          ),
                          ListTitleEveningAlarm(
                            beforeAzanHelfHour: 0,
                            beforeAzanHour: 2,
                            id: 19,
                            title: 'تذكير بعد صلاة العصر بساعتين',
                            prayerTime: widget.prayerTime.data.timings.asr,
                            onOffEveningAlarmState: state,
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
