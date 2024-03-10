// ignore_for_file: must_be_immutable

import 'package:wrd/features/islamic_corner/azkar/domain/entities/zkar_entities/zkar_array.dart';

class ZkarArrayModel extends ZkarArray {
  ZkarArrayModel({
    required super.id,
    required super.text,
    required super.count,
    required super.repeat,
  });

  factory ZkarArrayModel.fromJson(Map<String, dynamic> json) => ZkarArrayModel(
        id: json['id'],
        text: json['text'],
        count: json['count'],
        repeat: json['repeat'],
      );
}
