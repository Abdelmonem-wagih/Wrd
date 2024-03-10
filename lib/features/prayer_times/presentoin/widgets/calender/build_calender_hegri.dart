import 'package:flutter/material.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/features/prayer_times/domain/entities/prayer_times/prayer_times.dart';
import 'package:wrd/features/prayer_times/presentoin/screen/calendar_hegri.dart';

class BuildCalenderHegri extends StatelessWidget {
  const BuildCalenderHegri({
    super.key,
    required this.prayerTime,
    required this.prayerTimeName,
    required this.prayerTimeTime,
  });

  final PrayerTime prayerTime;
  final String prayerTimeName;
  final String prayerTimeTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          prayerTimeName,
          style: TextStyle(
              color: prayerTime.date!.gregorian!.date! == actualDay
                  ? AppColors.dark
                  : Colors.grey,
              fontWeight: FontWeight.normal,
              fontFamily: "Almarai",
              fontStyle: FontStyle.normal,
              fontSize: 15.0),
        ),
        Text(
          prayerTimeTime,
          style: TextStyle(
              color: prayerTime.date!.gregorian!.date! == actualDay
                  ? AppColors.dark
                  : Colors.grey,
              fontWeight: FontWeight.normal,
              fontFamily: "Almarai",
              fontStyle: FontStyle.normal,
              fontSize: 15.0),
        ),
      ],
    );
  }
}
