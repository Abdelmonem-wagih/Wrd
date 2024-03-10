// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Gregorian extends Equatable {
  String? date;
  String? day;

  Gregorian({
    required this.day,
    required this.date,
  });

  @override
  List<Object?> get props => [date, day];
}
