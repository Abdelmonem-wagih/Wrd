// ignore_for_file: must_be_immutable

import '../../../domain/entities/prayer_times/month.dart';

class MonthModel extends Month {
  MonthModel({required super.number, required super.en});
  factory MonthModel.fromJson(Map<String, dynamic> json) =>
      MonthModel(number: json['number'], en: json['en']);
}

