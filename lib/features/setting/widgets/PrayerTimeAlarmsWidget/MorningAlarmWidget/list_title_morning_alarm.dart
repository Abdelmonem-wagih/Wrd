import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wrd/core/utils/app_colors.dart';
import '../../../cubit/controller/control_morning_prayers_cubit.dart';
import '../DhuhaAlarmWidget/list_title_dhuha_alarm.dart';
import '../../../../../core/services/alarm_helper.dart';

class ListTitleMorningAlarm extends StatelessWidget {
  const ListTitleMorningAlarm({
    super.key,
    required this.title,
    required this.prayerTime,
    required this.id,
    required this.beforeAzanHour,
    required this.beforeAzanHelfHour,
    required this.onOffMorningAlarmState,
  });

  final int id;
  final int beforeAzanHour;
  final int beforeAzanHelfHour;
  final String title;
  final String prayerTime;
  final bool onOffMorningAlarmState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlMorningPrayersCubit, String>(
      builder: (context, state) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: onOffMorningAlarmState == true
                  ? state == title
                      ? AppColors.lightYellow
                      : Colors.white
                  : Colors.white,
              fontWeight: FontWeight.w400,
              fontFamily: "Almarai",
              fontStyle: FontStyle.normal,
              fontSize: 16.0,
            ),
          ),
          leading: SvgPicture.asset(
            'assets/svg/icon_volume.svg',
            color: onOffMorningAlarmState == true
                ? state == title
                    ? AppColors.lightYellow
                    : Colors.white
                : Colors.white,
          ),
          onTap: () async {
            context
                .read<ControlMorningPrayersCubit>()
                .selectMorningPrayers(title);

            if (onOffMorningAlarmState == true) {
              AlarmHelper.createAzkarAlarm(
                afterAzanHour: beforeAzanHour,
                afterAzanHelfHour: beforeAzanHelfHour,
                prayerTimeName: 'أذكار الصباح',
                id: id,
                prayerTime: prayerTime,
                titleNotification: 'أذكار الصباح',
                bodyNotification:
                    'عَنْ أَبِي هُرَيْرَةَ ، قَالَ : قَالَ رَسُولُ اللهِ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ : ( مَنْ'
                    ' قَالَ: حِينَ يُصْبِحُ وَحِينَ يُمْسِي : سُبْحَانَ اللهِ وَبِحَمْدِهِ ، مِائَةَ مَرَّةٍ ، لَمْ'
                    ' يَأْتِ أَحَدٌ يَوْمَ الْقِيَامَةِ ، بِأَفْضَلَ مِمَّا جَاءَ بِهِ ، إِلَّا أَحَدٌ قَالَ مِثْلَ مَا قَالَ ،'
                    ' أَوْ زَادَ عَلَيْهِ ) .',
              );
            }
            cancelRelatedReminders(
              id: id,
              idsToCancel: [12, 13, 14, 15],
            );
          },
          trailing: onOffMorningAlarmState == true && state == title
              ? const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.lightYellow,
                )
              : null,
        );
      },
    );
  }
}
