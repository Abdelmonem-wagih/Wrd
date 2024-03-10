// ignore_for_file: must_be_immutable

import '../../../domain/entities/prayer_times/weekday.dart';

class WeekdayModel extends Weekday {
  WeekdayModel({required super.en, required super.ar});

  factory WeekdayModel.fromJson(Map<String, dynamic> json) => WeekdayModel(
        en: json['en'],
        ar: json['ar'],
      );
}
