import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static void init() {
    initialize();
  }

  static final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  static void push({
    int? id,
    required String title,
    required String body,
    required String muezzin,
  }) {

    initialize();
    var androidDetails = AndroidNotificationDetails(
      'alarm_channel',
      'Alarm',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      autoCancel: true,
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      styleInformation: BigTextStyleInformation(
        body,
        contentTitle: title,
        summaryText: title,
      ),
      sound: RawResourceAndroidNotificationSound(muezzin),

      // sound: RawResourceAndroidNotificationSound('alarm'),
    );

    final details = NotificationDetails(android: androidDetails);
    plugin.show(id ?? 0, title, body, details, payload: id.toString());
  }


  static void pushWithOutAudio({
    int? id,
    required String title,
    required String body,
  }) {

    initialize();
    final androidDetails = AndroidNotificationDetails(
      'alarm_channel_withOut_sound',
      'Alarm_withOut_sound',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      autoCancel: true,
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      styleInformation: BigTextStyleInformation(
        body,
        summaryText: title,
      ),
      sound: const RawResourceAndroidNotificationSound(''),

      // sound: RawResourceAndroidNotificationSound('alarm'),
    );

    final details = NotificationDetails(android: androidDetails);
    plugin.show(id ?? 0, title, body, details, payload: id.toString());
  }

  static void pushGazaALarm() async {
    initialize();
    final String bigPicturePath = await _downloadAndSaveFile(
        'https://mir-s3-cdn-cf.behance.net/projects/404/9349fa182450721.Y3JvcCwyNzYxLDIxNjAsNDc4LDA.jpg',
        'bigPicture');

    final androidDetails = AndroidNotificationDetails('alarm_channel', 'Alarm',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        autoCancel: true,
        largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        styleInformation: BigPictureStyleInformation(
          FilePathAndroidBitmap(bigPicturePath),
          hideExpandedLargeIcon: true,
        )
        // sound: RawResourceAndroidNotificationSound('alarm'),
        );
    final details = NotificationDetails(android: androidDetails);
    plugin.show(
        49,
        'متنســاش إخــواتك',
        'إخــواتك بيتم إبداتهم بشكل همجي '
            'إدعــم وإنشــر واكتــب '
            'واتكلــم عنهــم اوعــى تنســاهم',
        details,
        payload: 'غــــزه');
  }

  static void initialize() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        debugPrint('details.payload details.payload ');
        debugPrint(details.payload);
      },
    );
  }

  static void cancel(int id) {
    plugin.cancel(id);
  }
}

Future<String> _downloadAndSaveFile(String url, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final http.Response response = await http.get(Uri.parse(url));
  final File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}
