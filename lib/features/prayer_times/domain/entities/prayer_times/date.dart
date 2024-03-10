import 'package:equatable/equatable.dart';

import 'gregorian.dart';
import 'hijri.dart';

// ignore: must_be_immutable
class Date extends Equatable {
  Gregorian? gregorian;
  Hijri? hijri;

  Date({
    required this.gregorian,
    required this.hijri,
  });

  @override
  List<Object?> get props => [gregorian, hijri];
}