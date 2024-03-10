
// ignore_for_file: must_be_immutable

import '../../../domain/entities/prayer_times/gregorian.dart';

class GregorianModel extends Gregorian {
  GregorianModel({
    required super.date,
    required super.day,
  });

  factory GregorianModel.fromJson(Map<String, dynamic> json) => GregorianModel(
        date: json['date'],
        day: json['day'],
      );
}