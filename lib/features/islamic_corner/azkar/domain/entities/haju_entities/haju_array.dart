// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class HajuArray extends Equatable {
  int? id;
  String? text;
  int? count;
  String? repeat;

  HajuArray({
    required this.id,
    required this.text,
    required this.count,
    required this.repeat,
  });

  @override
  List<Object?> get props => [
        id,
        text,
        count,
        repeat,
      ];
}
