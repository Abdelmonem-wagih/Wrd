// ignore_for_file: must_be_immutable

import '../../../domain/entities/azkar_entities/azkar_array.dart';

class ArrayModel extends AzkarArray {
  ArrayModel({
    required super.id,
    required super.text,
    required super.count,
    required super.repeat,
    required super.bless,
    
  });

  factory ArrayModel.fromJson(Map<String, dynamic> json) => ArrayModel(
        id: json['id'],
        text: json['text'],
        count: json['count'],
        repeat: json['repeat'],
        bless: json['bless'],
      );
}
