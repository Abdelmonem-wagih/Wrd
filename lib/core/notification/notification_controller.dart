import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timezone/timezone.dart' as tz;
import '../utils/app_colors.dart';
import '../utils/convert_time.dart';
import 'notification_pluging.dart';

class PaddedElevatedButton extends StatelessWidget {
  const PaddedElevatedButton({
    required this.buttonText,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(
              FontAwesomeIcons.bell,
              color: AppColors.white,
            ),
            Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontFamily: "Almarai",
                fontStyle: FontStyle.normal,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> cancelPrayerTimeNotifications({required int id}) async {
  print(
      '=>>>>>>>>>>>>>>>>>>>>>>>>>>>>> cancel prayer time id : $id <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<=');
  await flutterLocalNotificationsPlugin.cancel(id);
}

Future<void> scheduleDhuhaNotification({
  required String prayerTime,
  required int id,
  required int beforeAzanHour,
  required int beforeAzanHelfHour,
  required String prayerTimeName,
}) async {
  print(
      '=>>>>>>>>>>>>>>>>>>>>>>>>>>>>> pressed $prayerTimeName <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<=');
  String timing = formatTime(prayerTime);
  final timingHour = int.parse(timing.split(':')[0]);
  final timingMin = int.parse(timing.split(':')[1]);
  await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'صلاة الضحي',
      'عَنْ أَبِي ذَرٍّ رضي الله عنه عَنْ النَّبِيِّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ أَنَّهُ قَالَ'
          ' : ( يُصْبِحُ عَلَى كُلِّ سُلَامَى مِنْ أَحَدِكُمْ صَدَقَةٌ ، فَكُلُّ تَسْبِيحَةٍ صَدَقَةٌ'
          ' ، وَكُلُّ تَحْمِيدَةٍ صَدَقَةٌ ، وَكُلُّ تَهْلِيلَةٍ صَدَقَةٌ',
      _nextInstanceOfTenAM(
        hour: timingHour - beforeAzanHour,
        minute: timingMin - beforeAzanHelfHour,
      ),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'Dhurh notification channel $id',
          'Dhurh notification channel $prayerTime',
          channelDescription: 'daily notification $prayerTimeName',
          sound:
              const RawResourceAndroidNotificationSound('azan_yasser_aldosari'),
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
}

Future<void> scheduleAzkerNotification({
  required String prayerTime,
  required int id,
  required int afterAzanHour,
  required int afterAzanHelfHour,
  required String prayerTimeName,
  required String titleNotification,
  required String bodyNotification,
}) async {
  print(
      '=>>>>>>>>>>>>>>>>>>>>>>>>>>>>> pressed $prayerTimeName <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<=');
  String timing = formatTime(prayerTime);
  final timingHour = int.parse(timing.split(':')[0]);
  final timingMin = int.parse(timing.split(':')[1]);
  await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      titleNotification,
      bodyNotification,
      _nextInstanceOfTenAM(
        hour: timingHour + afterAzanHour,
        minute: timingMin + afterAzanHelfHour,
      ),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'Dhurh notification channel $id',
          'Dhurh notification channel $prayerTime',
          channelDescription: 'daily notification $prayerTimeName',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
}

Future<void> scheduleDailyPrayerTimeNotification({
  required String prayerTime,
  required int id,
  required String prayerTimeName,
  required String muezzin,
}) async {
  print(
      '=>>>>>>>>>>>>>>>>>>>>>>>>>>>>> pressed $prayerTimeName <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<=');
  String timing = formatTime(prayerTime);
  final timingHour = int.parse(timing.split(':')[0]);
  final timingMin = int.parse(timing.split(':')[1]);
  print('timingHour:=>>>> $timingHour ///// timingMin=>>>>>>>> $timingMin');
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    ' أذان $prayerTimeName ',
    ' يحين الان اذان  $prayerTimeName',
    _nextInstanceOfTenAM(hour: timingHour, minute: timingMin),
    NotificationDetails(
      android: AndroidNotificationDetails(
        'Dhurh notification channel $id',
        'Dhurh notification channel $prayerTime',
        channelDescription: 'daily notification $prayerTimeName',
        sound: RawResourceAndroidNotificationSound(muezzin),
      ),
      iOS: DarwinNotificationDetails(
        sound: muezzin,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

tz.TZDateTime _nextInstanceOfTenAM({required int hour, required int minute}) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  print('scheduledDate :=>>>>>>>>>>>>>>>>>>>>> $scheduledDate');
  return scheduledDate;
}

Future<void> zonedScheduleNotification() async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'daily scheduled notification title',
      'daily scheduled notification body',
      _nextInstanceOfTenAM(hour: 3, minute: 3),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily notification channel id',
          'daily notification channel name',
          channelDescription: 'daily notification description',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
}
