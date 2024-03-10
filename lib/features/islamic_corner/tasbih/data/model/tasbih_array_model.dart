// ignore_for_file: must_be_immutable

import '../../domain/entities/tasbih_array.dart';

class TasbihArrayModel extends TasbihArray {
  TasbihArrayModel({
    required super.id,
    required super.text,
    required super.count,
    required super.title,
  });

  factory TasbihArrayModel.fromJson(Map<String, dynamic> json) =>
      TasbihArrayModel(
        id: json['id'],
        text: json['text'],
        title: json['title'],
        count: json['count'],
      );
}
