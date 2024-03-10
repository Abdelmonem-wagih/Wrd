// ignore_for_file: must_be_immutable

import 'package:wrd/features/islamic_corner/azkar/domain/entities/tawba_entities/tawba_array.dart';

class TawbaArrayModel extends TawbaArray {
  TawbaArrayModel({
    required super.id,
    required super.text,
    required super.count,
    required super.repeat,
  });
  factory TawbaArrayModel.fromJson(Map<String, dynamic> json) =>
      TawbaArrayModel(
        id: json['id'],
        text: json['text'],
        count: json['count'],
        repeat: json['repeat'],
      );
}
