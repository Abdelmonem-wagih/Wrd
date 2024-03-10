// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:wrd/features/prayer_times/domain/entities/prayer_times/prayer_times.dart';

import 'date_model.dart';
import 'timings_model.dart';

class PrayerTimesModel extends PrayerTime {
  PrayerTimesModel({
    required super.timings,
    required super.date,
  });
  factory PrayerTimesModel.fromJson(Map<String, dynamic> json) =>
      PrayerTimesModel(
        timings: json['timings'] != null
            ? TimingsModel.fromJson(json['timings'])
            : null,
        date: json['date'] != null ? DateModel.fromJson(json['date']) : null,
      );
}