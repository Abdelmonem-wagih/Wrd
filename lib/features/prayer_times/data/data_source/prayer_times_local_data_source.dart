import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wrd/core/error/exceptions2.dart';

import '../model/prayer_times_model/prayer_times_model.dart';

abstract class BasePrayerTimesLocalDataSource {
  Future<List<PrayerTimesModel>> getLastPrayerTimes();
  Future<void> cachePrayerTimes(List<PrayerTimesModel> prayer);
}

class PrayerTimesLocalDataSource implements BasePrayerTimesLocalDataSource {
  //SharedPreferences package
  final SharedPreferences sharedPreferences;
  PrayerTimesLocalDataSource({required this.sharedPreferences});
  @override
  Future<List<PrayerTimesModel>> getLastPrayerTimes() {
    final jsonString = sharedPreferences.getString("CACHED_PRAYER_TIMES");
    if (jsonString != null) {
      final cachePrayerTimes =
          Future.value(List<PrayerTimesModel>.from(json.decode(jsonString)));
      return cachePrayerTimes;
    } else {
      throw const ServerException("Eroooor");
    }
  }

  @override
  Future<void> cachePrayerTimes(List<PrayerTimesModel> prayer) {
    return sharedPreferences.setString(
        "CACHED_PRAYER_TIMES", jsonEncode(prayer));
  }
}
