// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Weekday extends Equatable {
   String? en;
  String? ar;


  Weekday({required this.en , required this.ar});

  @override
  List<Object?> get props => [en , ar];
}