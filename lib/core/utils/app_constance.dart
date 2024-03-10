import 'package:flutter/cupertino.dart';

import 'app_string.dart';

const String PRAYER_TIMING_URL = 'http://api.aladhan.com/v1/timings/';

class AppSettings extends ChangeNotifier {
  bool _isReadOnly = false;

  bool get isReadOnly => _isReadOnly;

  void setReadOnly(bool value) {
    _isReadOnly = value;
    notifyListeners(); // Notify listeners about the change in state
  }
}

class AppConstance {
  static const String checkTafsirBot =
      'https://wrdapp.ofoq.solutions/api/v1/aya_exists/';
  static const String tafsirBot =
      'https://wrdapp.ofoq.solutions/api/v1/tafsir/';

  String basePrayerTimeURL = "https://api.aladhan.com/v1/hijriCalendar";
  static const String quranChaptersApi =
      "https://api.quran.com/api/v4/chapters?language=eng";
  static const String quranApi =
      'http://api.alquran.cloud/v1/quran/quran-uthmani'; // 'https://api.quran.com/api/v4/quran/verses/uthmani';
  static const String quranAudio =
      'https://www.mp3quran.net/api/v3/reciters'; //'https://api.quran.com/api/v4/chapter_recitations/40?language=en';
  static const String rewayat = 'https://www.mp3quran.net/api/v3/riwayat';
  static const baseLocation = 'https://nominatim.openstreetmap.org/reverse?format=jsonv2&';
  //https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=30.1294918%20&lon=31.7185656
  String loaction(double latitude, double longitude) {
    return '$baseLocation$latitude/$longitude/ar';
  }

  String prayerTimesApi(int numberYears, int numberMonth) {
    return "$basePrayerTimeURL/$numberYears/$numberMonth?latitude=30.1316123&longitude=31.7295788&method=5";
  }

  String getImage(String imageUrl) {
    if (imageUrl == AppString.Fajr) {
      return 'icon_eshaa';
    } else if (imageUrl == AppString.Dhuhr) {
      return 'background_fagr';
    } else if (imageUrl == AppString.Asr) {
      return 'icon_dohr';
    } else if (imageUrl == AppString.Maghrib) {
      return 'icon_asr';
    } else {
      return 'icon_mghrb';
    }
  }

  ////JsonsFile
  static const String quranChapter = 'assets/jsons_file/quranChapter.json';
  static const String azkarJson = 'assets/jsons_file/الاذكار.json';
  static const String dueaJson = 'assets/jsons_file/الادعية.json';
  static const String tasbihJson = 'assets/jsons_file/تسابيح.json';
  static const String zkarJson = 'assets/jsons_file/الذكر.json';
  static const String tawbaJson = 'assets/jsons_file/الاستغفار والتوبة.json';
  static const String tashahhudJson =
      'assets/jsons_file/التشهد والصلاة علي النبي.json';
  static const String hajuJson = 'assets/jsons_file/الحج.json';
  static const String saysJson = 'assets/jsons_file/ما يقول العبد.json';
}
