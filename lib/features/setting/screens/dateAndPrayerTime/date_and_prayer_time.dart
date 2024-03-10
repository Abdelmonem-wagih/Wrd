import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/features/setting/widgets/list_title_widget.dart';
import 'package:wrd/main.dart';
import '../../../../core/services/switch_helper.dart';
import '../../cubit/on_off_switch/on_off_prayertime_cubit.dart';
import '../../widgets/PrayerTimeAlarmsWidget/DhuhaAlarmWidget/list_title_dhuha_alarm.dart';
import '../../widgets/PrayerTimeAlarmsWidget/switch_icon.dart';
import '../../widgets/control_adhan_asr_timing.dart';
import '../../widgets/switch_prayertime_icon.dart';

class DateAndPrayerTime extends StatelessWidget {
  const DateAndPrayerTime({super.key});

  //
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
          'التاريخ و مواقيت الصلاة',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            fontFamily: "Almarai",
            fontStyle: FontStyle.normal,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.darkTone,
            ),
            child: Column(
              children: [
                ListTitleWidget(
                  widget: BlocBuilder<OnOffPrayerTimeCubit, bool>(
                    builder: (context, state) {

                      return GestureDetector(
                        onTap: () {
                          state = !state;
                          cancelRelatedReminders(
                            id: 0,
                            idsToCancel: [1, 2, 3, 4, 5, 6, 7],
                          );
                          //NumberCubit
                          context.read<NumberCubit>().setNumber(0);
                          context
                              .read<OnOffPrayerTimeCubit>()
                              .switchOnOffPrayerTime();
                        },
                        child: SwitchHelper(switchValue: state),
                      );
                    },
                  ),
                  text: 'تفعيل مواقيت الصلاة',
                ),
                const ListTitleWidget(
                  widget: SwitchPrayerTimeIcon(
                    id: 2,
                  ),
                  text: 'تحديد تلقائى لطرق حساب المواقيت',
                ),
                const ListTitleWidget(
                  widget: SwitchPrayerTimeIcon(
                    id: 3,
                  ),
                  text: 'تحديد الموقع الخاص بك كل ساعة',
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.darkTone,
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    _showOptions(context);
                  },
                  child: const ListTitleWidget(
                    trailingIcon: Icons.arrow_back_ios_new_sharp,
                    text: 'الحساب الفقهي لصلاة العصر',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkTone,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ControlAdhanAsrTiming(
                selectSchool: 'شافعي - مالكي - حنبلي',
              ),
              const SizedBox(height: 16),
              const ControlAdhanAsrTiming(
                selectSchool: 'حنفي',
              ),
            ],
          ),
        );
      },
    );
  }
}
