import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/features/setting/cubit/controller/control_dhuha_prayer_cubit.dart';
import '../../../../../core/services/alarm_helper.dart';

class ListTitleDhuhaAlarm extends StatelessWidget {
  const ListTitleDhuhaAlarm({
    super.key,
    required this.title,
    required this.prayerTime,
    required this.id,
    required this.beforeAzanHour,
    required this.beforeAzanHelfHour,
    required this.onOffDhuhaAlarmState,
  });

  final int id;
  final int beforeAzanHour;
  final int beforeAzanHelfHour;
  final String title;
  final String prayerTime;
  final bool onOffDhuhaAlarmState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlDhuhaPrayerCubit, String>(
      builder: (context, state) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: onOffDhuhaAlarmState == true
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
            color: onOffDhuhaAlarmState == true
                ? state == title
                    ? AppColors.lightYellow
                    : Colors.white
                : Colors.white,
          ),
          onTap: () async {
            context.read<ControlDhuhaPrayerCubit>().selectDhuhaPrayer(title);
            if (onOffDhuhaAlarmState == true) {
              AlarmHelper.createDhuhaAlarm(
                beforeAzanHour: beforeAzanHour,
                beforeAzanHelfHour: beforeAzanHelfHour,
                prayerTimeName: 'صلاة الضحي',
                id: id,
                prayerTime: prayerTime,
              );
            }
            cancelRelatedReminders(id: id, idsToCancel: [8, 9, 10, 11]);
          },
          trailing: onOffDhuhaAlarmState == true
              ? state == title
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.lightYellow,
                    )
                  : null
              : null,
        );
      },
    );
  }
}

void cancelRelatedReminders({required int id, required List<int> idsToCancel}) {
  // Define a list of IDs that should be canceled for each case

  // Remove the current ID from the list
  idsToCancel.remove(id);

  // Cancel reminders for the remaining IDs in the list
  for (int idToCancel in idsToCancel) {
    AlarmHelper.cancelReminder(id: idToCancel);
  }
}
