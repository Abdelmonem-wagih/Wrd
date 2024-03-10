
// ignore_for_file: must_be_immutable

import '../../../domain/entities/prayer_times/date.dart';
import 'gregorian_model.dart';
import 'hijri_model.dart';

class DateModel extends Date {
  DateModel({
    required super.gregorian,
    required super.hijri,
  });
  factory DateModel.fromJson(Map<String, dynamic> json) => DateModel(
        gregorian: json['gregorian'] != null
            ? GregorianModel.fromJson(json['gregorian'])
            : null,
        hijri:
            json['hijri'] != null ? HijriModel.fromJson(json['hijri']) : null,
      );
}