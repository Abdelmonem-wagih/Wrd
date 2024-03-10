// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_new, must_be_immutable
import 'package:equatable/equatable.dart';

import 'date.dart';
import 'timings.dart';

class PrayerTime extends Equatable {
  Timings? timings;
  Date? date;

  PrayerTime({
    required this.timings,
    required this.date,
  });

  @override
  List<Object?> get props => [timings, date];
}









