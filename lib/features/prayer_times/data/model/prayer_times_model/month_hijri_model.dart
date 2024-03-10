import '../../../domain/entities/prayer_times/month_hijri.dart';

// ignore: must_be_immutable
class MonthHijriModel extends MonthHijri {
  MonthHijriModel({
    required super.number,
    required super.en,
    required super.ar,
  });

  factory MonthHijriModel.fromJson(Map<String, dynamic> json) => MonthHijriModel(
        number: json['number'],
        en: json['en'],
        ar: json['ar'],
      );
}
