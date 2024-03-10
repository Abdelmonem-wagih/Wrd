// ignore_for_file: must_be_immutable

import 'package:wrd/features/islamic_corner/azkar/domain/entities/tashahhud_entities/tashahhud_array.dart';

class TashahhudArrayModel extends TashahhudArray {
  TashahhudArrayModel({
    required super.id,
    required super.text,
    required super.count,
    required super.repeat,
  });
  factory TashahhudArrayModel.fromJson(Map<String, dynamic> json) =>
      TashahhudArrayModel(
        id: json['id'],
        text: json['text'],
        count: json['count'],
        repeat: json['repeat'],
      );
}
