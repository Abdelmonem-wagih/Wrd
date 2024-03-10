// ignore_for_file: must_be_immutable

import '../../domain/entities/duea_array.dart';

class DueaArrayModel extends DueaArray {
  DueaArrayModel({
    required super.id,
    required super.text,
    required super.count, required super.repeat,

  });

  factory DueaArrayModel.fromJson(Map<String, dynamic> json) => DueaArrayModel(
    id: json['id'],
    text: json['text'],
    count: json['count'],
    repeat: json['repeat'],
  );
}
