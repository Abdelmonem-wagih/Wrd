import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/features/setting/widgets/list_title_widget.dart';
import 'package:wrd/main.dart';
import '../../../../core/services/switch_helper.dart';
import '../../cubit/on_off_switch/on_off_dhuha_cubit.dart';
import '../../../prayer_timing/data/timing.dart';
import '../../widgets/PrayerTimeAlarmsWidget/DhuhaAlarmWidget/list_title_dhuha_alarm.dart';

class DhuhPrayerAlarm extends StatelessWidget {
  const DhuhPrayerAlarm({super.key, required this.prayerTime});

  final Timing prayerTime;

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
          'تذكير صلاة الضحي',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            fontFamily: "Almarai",
            fontStyle: FontStyle.normal,
            fontSize: 20.0,
          ),
        ),
      ),
      body: BlocBuilder<OnOffDhuhaCubit, bool>(
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
                        idsToCancel: [8, 9, 10, 11],
                      );

                      context.read<OnOffDhuhaCubit>().switchOnOffDhuha();
                    },
                    child: SwitchHelper(switchValue: state),
                  ),
                  leadingIcon: state == true
                      ? 'assets/svg/icon_voice_fill.svg'
                      : 'assets/svg/icon_oir_voice.svg',
                  text: 'صلاة الضحي',
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
                          ListTitleDhuhaAlarm(
                            beforeAzanHelfHour: 30,
                            beforeAzanHour: 0,
                            id: 8,
                            title: 'تذكير قبل صلاة الظهر بنصف ساعة',
                            prayerTime: prayerTime.data.timings.dhuhr,
                            onOffDhuhaAlarmState: state,
                          ),
                          const Divider(
                            color: AppColors.white,
                            thickness: 0.5,
                          ),
                          ListTitleDhuhaAlarm(
                            title: 'تذكير قبل صلاة الظهر بساعة',
                            id: 9,
                            beforeAzanHelfHour: 0,
                            beforeAzanHour: 1,
                            prayerTime: prayerTime.data.timings.dhuhr,
                            onOffDhuhaAlarmState: state,
                          ),
                          const Divider(
                            color: AppColors.white,
                            thickness: 0.5,
                          ),
                          ListTitleDhuhaAlarm(
                            title: 'تذكير قبل صلاة الظهر بساعتين',
                            id: 10,
                            beforeAzanHelfHour: 0,
                            beforeAzanHour: 2,
                            prayerTime: prayerTime.data.timings.dhuhr,
                            onOffDhuhaAlarmState: state,
                          ),
                          const Divider(
                            color: AppColors.white,
                            thickness: 0.5,
                          ),
                          ListTitleDhuhaAlarm(
                            title: 'تذكير قبل صلاة الظهر بثلاث ساعات',
                            id: 11,
                            beforeAzanHelfHour: 0,
                            beforeAzanHour: 3,
                            prayerTime: prayerTime.data.timings.dhuhr,
                            onOffDhuhaAlarmState: state,
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
