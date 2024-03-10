// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';

class MonthHijri extends Equatable {
  int? number;
  String? en;
  String? ar;

  MonthHijri({
    required this.number,
    required this.en,
    required this.ar,
  });


  @override
  List<Object?> get props => [number, en, ar];
}
