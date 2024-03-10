
// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:wrd/features/prayer_times/domain/entities/prayer_times/month_hijri.dart';

import 'weekday.dart';

class Hijri extends Equatable {
  String? date;
  String? day;
  Weekday? weekday;
  MonthHijri? month;
  String? year;

  Hijri({
    required this.date,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
  });

  @override
  List<Object?> get props => [date, day, weekday, month , year];
}