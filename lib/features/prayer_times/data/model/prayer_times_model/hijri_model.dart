// ignore_for_file: must_be_immutable

import '../../../domain/entities/prayer_times/hijri.dart';
import 'month_hijri_model.dart';
import 'weekday_model.dart';

class HijriModel extends Hijri {
  HijriModel({
    required super.date,
    required super.day,
    required super.weekday,
    required super.month,
    required super.year,
  });

  factory HijriModel.fromJson(Map<String, dynamic> json) => HijriModel(
        date: json['date'],
        day: json['day'],
        weekday: json['weekday'] != null
            ? WeekdayModel.fromJson(json['weekday'])
            : null,
        month:
            json['month'] != null ? MonthHijriModel.fromJson(json['month']) : null,
        year: json['year'],
      );
}
