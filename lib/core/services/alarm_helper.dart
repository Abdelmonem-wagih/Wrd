import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';

import '../../features/setting/controller/muezzin_preferences.dart';
import '../utils/convert_time.dart';
import 'notification_helper.dart';

class AlarmHelper {
  ///Notification For Prayer Time
  static void createPrayerTimeAlarm({
    required String prayerTime,
    required int id,
    required String prayerTimeName,
  }) async {
    debugPrint(
        '=>>>>>>>>>>>>>>>>>>>>>>>>>>>>> pressed $prayerTimeName <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<=');
    String timing = formatTime(prayerTime);
    final timingHour = int.parse(timing.split(':')[0]);
    final timingMin = int.parse(timing.split(':')[1]);

    debugPrint(
        'timingHour:=>>>> $timingHour ///// timingMin=>>>>>>>> $timingMin ////// ');

    AndroidAlarmManager.oneShotAt(
      _buildDateTimeWithDelay(hour: timingHour, minute: timingMin), // time
      id, // id
      notify,
      params: {
        'id': id,
        'title': ' أذان $prayerTimeName ',
        'body': ' يحين الان اذان  $prayerTimeName',
      },
      rescheduleOnReboot: true,
      exact: true,
      alarmClock: true,
    );
  }
  ///Notification for Dhuha
  static void createSunriseAlarm({
    required String prayerTime,
    required int id,
    required String prayerTimeName,
    required String body,
  }) async {
    debugPrint(
        '=>>>>>>>>>>>>>>>>>>>>>>>>>>>>> pressed $prayerTimeName <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<=');
    String timing = formatTime(prayerTime);
    final timingHour = int.parse(timing.split(':')[0]);
    final timingMin = int.parse(timing.split(':')[1]);

    debugPrint(
        'timingHour:=>>>> $timingHour ///// timingMin=>>>>>>>> $timingMin ////// ');

    AndroidAlarmManager.oneShotAt(
      _buildDateTimeWithDelay(hour: timingHour, minute: timingMin), // time
      id, // id
      notifyWithOutAudio,
      params: {
        'id': id,
        'title': ' الان $prayerTimeName ',
        'body': body,
      },
      rescheduleOnReboot: true,
      exact: true,
      alarmClock: true,
    );
  }

  static void createFajrAlarm({
    required String prayerTime,
    required int id,
    required String prayerTimeName,
  }) async {
    debugPrint(
        '=>>>>>>>>>>>>>>>>>>>>>>>>>>>>> pressed $prayerTimeName <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<=');
    String timing = formatTime(prayerTime);
    final timingHour = int.parse(timing.split(':')[0]);
    final timingMin = int.parse(timing.split(':')[1]);

    debugPrint(
        'timingHour:=>>>> $timingHour ///// timingMin=>>>>>>>> $timingMin ////// ');

    AndroidAlarmManager.oneShotAt(
      _buildDateTimeWithDelay(hour: timingHour, minute: timingMin), // time
      id, // id
      notifyFajr,
      params: {
        'id': id,
        'title': ' أذان $prayerTimeName ',
        'body': ' يحين الان اذان  $prayerTimeName',
      },
      rescheduleOnReboot: true,
      exact: true,
      alarmClock: true,
    );
  }


  ///Notification for Dhuha
  static void createDhuhaAlarm({
    required String prayerTime,
    required int id,
    required int beforeAzanHour,
    required int beforeAzanHelfHour,
    required String prayerTimeName,
  }) async {
    debugPrint(
        '=>>>>>>>>>>>>>>>>>>>>>>>>>>>>> pressed $prayerTimeName <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<=');
    String timing = formatTime(prayerTime);
    final timingHour = int.parse(timing.split(':')[0]);
    final timingMin = int.parse(timing.split(':')[1]);

    debugPrint(
        'timingHour:=>>>> $timingHour ///// timingMin=>>>>>>>> $timingMin ');

    AndroidAlarmManager.oneShotAt(
      _buildDateTimeWithDelay(
        hour: timingHour - beforeAzanHour,
        minute: timingMin - beforeAzanHelfHour,
      ), // time
      id, // id
      notifyWithOutAudio,
      params: {
        'id': id,
        'title': 'صلاة الضحي',
        'body': 'عَنْ أَبِي ذَرٍّ رضي الله عنه عَنْ النَّبِيِّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ أَنَّهُ قَالَ'
            ' : ( يُصْبِحُ عَلَى كُلِّ سُلَامَى مِنْ أَحَدِكُمْ صَدَقَةٌ ، فَكُلُّ تَسْبِيحَةٍ صَدَقَةٌ'
            ' ، وَكُلُّ تَحْمِيدَةٍ صَدَقَةٌ ، وَكُلُّ تَهْلِيلَةٍ صَدَقَةٌ',
      },
      rescheduleOnReboot: true,
      exact: true,
      alarmClock: true,
    );
  }

  ///Notification for Azkar
  static void createAzkarAlarm({
    required String prayerTime,
    required int id,
    required int afterAzanHour,
    required int afterAzanHelfHour,
    required String prayerTimeName,
    required String titleNotification,
    required String bodyNotification,
  }) async {
    debugPrint(
        '=>>>>>>>>>>>>>>>>>>>>>>>>>>>>> pressed $prayerTimeName <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<=');
    String timing = formatTime(prayerTime);
    final timingHour = int.parse(timing.split(':')[0]);
    final timingMin = int.parse(timing.split(':')[1]);

    debugPrint(
        'timingHour:=>>>> $timingHour ///// timingMin=>>>>>>>> $timingMin ');

    AndroidAlarmManager.oneShotAt(
      _buildDateTimeWithDelay(
        hour: timingHour + afterAzanHour,
        minute: timingMin + afterAzanHelfHour,
      ), // time
      id, // id
      notifyWithOutAudio,
      params: {
        'id': id,
        'title': titleNotification,
        'body': bodyNotification,

      },
      rescheduleOnReboot: true,
      exact: true,
      alarmClock: true,
    );
  }

  static void createGazaAlarm() async {
    debugPrint('timingHour:=>>>> 8 ///// timingMin=>>>>>>>> 00');
    AndroidAlarmManager.oneShotAt(
      _buildDateTimeWithDelay(
        hour: 20,
        minute: 0,
      ), // time
      49, // id
      notifyGaza,
      rescheduleOnReboot: true,
      exact: true,
      alarmClock: true,
    );
  }

  /// Cancel Notification
  static Future<bool> cancelReminder({required int id}) async {
    return await AndroidAlarmManager.cancel(id);
  }

  ///call this when the time is coming
  @pragma('vm:entry-point')
  static void notify(int id, Map<String, dynamic> params) async {
    String? muezzin = await MuezzinPreferences.getMuezzin();
    muezzin ??= 'adhan_eabdalbasit_eabd_alsamad';
    NotificationHelper.push(
      id: params['id'],
      title: params['title'],
      body: params['body'],
      muezzin: muezzin,
    );
  }

  ///call this when the time is coming
  @pragma('vm:entry-point')
  static void notifyFajr(int id, Map<String, dynamic> params) async {
    String? muezzin = await MuezzinPreferencesFajr.getMuezzin();
    muezzin ??= 'adhan_mishari_bin_rashid_alafasy';
    NotificationHelper.push(
      id: params['id'],
      title: params['title'],
      body: params['body'],
      muezzin: muezzin,
    );
  }

  @pragma('vm:entry-point')
  static void notifyWithOutAudio(int id, Map<String, dynamic> params) async {

    NotificationHelper.pushWithOutAudio(
      id: params['id'],
      title: params['title'],
      body: params['body'],
    );
  }

//'متنســاش إخــواتك'
  @pragma('vm:entry-point')
  static void notifyGaza() async {
    debugPrint('Notify Gaza =>>>>> ');

    NotificationHelper.pushGazaALarm();
  }
}

DateTime _buildDateTimeWithDelay({required int hour, required int minute}) {
  DateTime now = DateTime.now();
  DateTime scheduledDate = DateTime(now.year, now.month, now.day, hour, minute);

  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }

  return scheduledDate;
}
