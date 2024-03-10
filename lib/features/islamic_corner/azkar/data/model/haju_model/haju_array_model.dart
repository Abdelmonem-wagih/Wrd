// ignore_for_file: must_be_immutable

import 'package:wrd/features/islamic_corner/azkar/domain/entities/haju_entities/haju_array.dart';

class HajuArrayModel extends HajuArray {
  HajuArrayModel({
    required super.id,
    required super.text,
    required super.count,
    required super.repeat,
  });

  factory HajuArrayModel.fromJson(Map<String, dynamic> json) => HajuArrayModel(
        id: json['id'],
        text: json['text'],
        count: json['count'],
        repeat: json['repeat'],
      );
}
