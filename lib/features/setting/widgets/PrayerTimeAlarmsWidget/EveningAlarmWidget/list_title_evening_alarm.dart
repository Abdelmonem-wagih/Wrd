import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/features/setting/cubit/controller/control_evening_prayers_cubit.dart';
import '../../../../../core/services/alarm_helper.dart';
import '../DhuhaAlarmWidget/list_title_dhuha_alarm.dart';

class ListTitleEveningAlarm extends StatelessWidget {
  const ListTitleEveningAlarm({
    super.key,
    required this.title,
    required this.prayerTime,
    required this.id,
    required this.beforeAzanHour,
    required this.beforeAzanHelfHour,
    required this.onOffEveningAlarmState,
  });

  final int id;
  final int beforeAzanHour;
  final int beforeAzanHelfHour;
  final String title;
  final String prayerTime;
  final bool onOffEveningAlarmState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlEveningPrayersCubit, String>(
      builder: (context, state) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: onOffEveningAlarmState == true
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
            color: onOffEveningAlarmState == true
                ? state == title
                    ? AppColors.lightYellow
                    : Colors.white
                : Colors.white,
          ),
          onTap: () async {
            context
                .read<ControlEveningPrayersCubit>()
                .selectEveningPrayers(title);

            if (onOffEveningAlarmState == true) {
              AlarmHelper.createAzkarAlarm(
                afterAzanHour: beforeAzanHour,
                afterAzanHelfHour: beforeAzanHelfHour,
                prayerTimeName: 'أذكار المساء',
                id: id,
                prayerTime: prayerTime,
                titleNotification: 'أذكار المساء',
                bodyNotification:
                    'عَنْ أَبِي هُرَيْرَةَ عَنِ النَّبِيِّ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ أَنَّهُ كَانَ يَقُولُ إِذَا'
                    ' أَمْسَى قَالَ : ( اللَّهُمَّ بِكَ أَمْسَيْنَا ، وَبِكَ أَصْبَحْنَا ، وَبِكَ نَحْيَا ، وَبِكَ نَمُوتُ ، '
                    'وَإِلَيْكَ الْمَصِيرُ ) .',
              );
            }
            cancelRelatedReminders(
              id: id,
              idsToCancel: [16, 17, 18, 19],
            );
          },
          trailing: onOffEveningAlarmState == true && state == title
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
