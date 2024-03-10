// ignore_for_file: must_be_immutable

import '../../../domain/entities/prayer_times/timings.dart';

class TimingsModel extends Timings {
  TimingsModel({
    required super.fajr,
    required super.sunrise,
    required super.dhuhr,
    required super.asr,
    required super.sunset,
    required super.maghrib,
    required super.isha,
    required super.imsak,
    required super.midnight,
    required super.firstthird,
    required super.lastthird,
  });

  factory TimingsModel.fromJson(Map<String, dynamic> json) => TimingsModel(
        fajr: json['Fajr'],
        sunrise: json['Sunrise'],
        dhuhr: json['Dhuhr'],
        asr: json['Asr'],
        sunset: json['Sunset'],
        maghrib: json['Maghrib'],
        isha: json['Isha'],
        imsak: json['Imsak'],
        midnight: json['Midnight'],
        firstthird: json['Firstthird'],
        lastthird: json['Lastthird'],
      );
}