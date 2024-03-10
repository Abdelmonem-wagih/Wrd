// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/features/prayer_timing/data/timing.dart';
import 'package:wrd/features/setting/widgets/list_title_widget.dart';
import 'package:wrd/main.dart';

import 'dateAndPrayerTime/date_and_prayer_time.dart';
import 'prayer_times_alarms/prayer_time_alarm.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key, required this.prayerTime});
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
          'الإعدادات',
          style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontFamily: "Almarai",
              fontStyle: FontStyle.normal,
              fontSize: 20.0),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset('assets/image/frame.png'),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.darkTone,
                ),
                child: Column(
                  children: [
                    //DateAndPrayerTime
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DateAndPrayerTime(),
                      )),
                      child: ListTitleWidget(
                        trailingIcon: Icons.arrow_back_ios_new_sharp,
                        leadingIcon:
                            'assets/svg/icon_calendar_date_fill_svgrepo_com_1.svg',
                        text: 'التاريخ و مواقيت الصلاة',
                      ),
                    ),
                    Divider(
                      color: AppColors.white,
                      thickness: 0.5,
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PrayerTimeAlarm(
                          timing: prayerTime,
                        ),
                      )),
                      child: ListTitleWidget(
                        trailingIcon: Icons.arrow_back_ios_new_sharp,
                        leadingIcon: 'assets/svg/icon_voice_fill.svg',
                        text: 'منبه الأذكار والأذان',
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  String? encodeQueryParameters(Map<String, String> params) {
                    return params.entries
                        .map((MapEntry<String, String> e) =>
                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                        .join('&');
                  }

                  final Uri emailUri = Uri(
                    scheme: 'mailto',
                    path: 'wrdapp@ofoq.solutions',
                    query: encodeQueryParameters(<String, String>{
                      'subject': 'مساعدة في تطبيق وِرْد',
                      'body':
                          'السلام عليكم ورحمه الله وبركاته ارجو الرد على استفسارى الا وهو :'
                              '',
                    }),
                  );
                  if (await canLaunchUrl(emailUri)) {
                    launchUrl(emailUri);
                  } else {
                    throw Exception('could not launch $emailUri');
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.brown,
                  ),
                  child: ListTitleWidget(
                    trailingIcon: null,
                    leadingIcon: 'assets/svg/icon_message_filled.svg',
                    text: 'تواصل معانا',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.darkTone,
                ),
                child: ListTitleWidget(
                  trailingIcon: null,
                  leadingIcon: 'assets/svg/icon_star_fill.svg',
                  text: 'قيم التطبيق',
                  subtitle: 'إذا أعجبك التطبيق قيم بـ 5 نجوم',
                ),
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment(0.5, -3.0616171314629196e-17),
                      end: Alignment(0.5, 0.9999999999999999),
                      colors: const [
                        AppColors.primary,
                        Color(0xff9c631d),
                      ],
                    ),
                  ),
                  child: ListTitleWidget(
                    trailingIcon: null,
                    leadingIcon: 'assets/svg/icon_solar_share_bold.svg',
                    text: 'شارك التطبيق',
                    subtitle: 'قم بمشاركة التطبيق مع اصدقائك وأقاربك.',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
