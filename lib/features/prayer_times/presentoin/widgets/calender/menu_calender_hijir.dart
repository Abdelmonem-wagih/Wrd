import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import '../../../../../core/utils/app_colors.dart';

import '../../cubit/prayer_time/prayer_times_cubit.dart';

class MenuCalenderHijir extends StatelessWidget {
  const MenuCalenderHijir({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Text("ترتيب الأشهر الهجرية",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: "Almarai",
                fontStyle: FontStyle.normal,
                fontSize: 20.0.fontSize,
              ),
              textAlign: TextAlign.right),
        ),
        const SizedBox(height: 30),
        const CalanderContcetWiget(monthName: "محرم", numberMonth: 1),
        const CalanderContcetWiget(monthName: "صفر", numberMonth: 2),
        const CalanderContcetWiget(monthName: "ربيع أول", numberMonth: 3),
        const CalanderContcetWiget(monthName: "ربيع الثاني", numberMonth: 4),
        const CalanderContcetWiget(monthName: "جماد الأول", numberMonth: 5),
        const CalanderContcetWiget(monthName: "جماد الثاني", numberMonth: 6),
        const CalanderContcetWiget(monthName: "رجب", numberMonth: 7),
        const CalanderContcetWiget(monthName: "شعبان", numberMonth: 8),
        const CalanderContcetWiget(monthName: "رمضان", numberMonth: 9),
        const CalanderContcetWiget(monthName: "شوال", numberMonth: 10),
        const CalanderContcetWiget(monthName: "ذو القعدة", numberMonth: 11),
        const CalanderContcetWiget(monthName: "ذو الحجة", numberMonth: 12),
      ],
    );
  }
}

class CalanderContcetWiget extends StatelessWidget {
  const CalanderContcetWiget({
    super.key,
    required this.monthName,
    required this.numberMonth,
  });
  final String monthName;
  final int numberMonth;
  static int numberMonthr = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, right: 15),
      child: InkWell(
        onTap: () {
          numberMonthr = numberMonth;
          context.read<PrayerTimesCubit>().getPrayerTimes();
          //Navigator.of(context).pop();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 20,
              color: AppColors.primary,
              child: Center(
                child: Text(
                  "$numberMonth",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 15.width),
            Text(
              monthName,
              style: TextStyle(
                color: const Color(0xb2634e36),
                fontWeight: FontWeight.w400,
                fontFamily: "Almarai",
                fontStyle: FontStyle.normal,
                fontSize: 16.0.fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
