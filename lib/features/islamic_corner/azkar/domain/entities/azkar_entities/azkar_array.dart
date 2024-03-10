// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class AzkarArray extends Equatable {
  int? id;
  String? text;
  int? count;
  String? repeat;
  String? bless;

  AzkarArray({
    required this.id,
    required this.text,
    required this.count,
    required this.repeat,
    required this.bless,
  });

  @override
  List<Object?> get props => [
        id,
        text,
        count,
        repeat,
        bless,
      ];
}
