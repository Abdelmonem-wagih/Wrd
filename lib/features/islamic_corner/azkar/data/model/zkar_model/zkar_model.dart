// ignore_for_file: must_be_immutable

import 'package:wrd/features/islamic_corner/azkar/data/model/zkar_model/zkar_array_model.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/entities/zkar_entities/zkar.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/entities/zkar_entities/zkar_array.dart';

class ZkarModel extends Zkar {
  ZkarModel({
    required super.id,
    required super.category,
    required super.array,
  });

  factory ZkarModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> arrayJson = json['array'];
    List<ZkarArray>? array =
        arrayJson.map((ayahJson) => ZkarArrayModel.fromJson(ayahJson)).toList();
    return ZkarModel(
      id: json['id'],
      category: json['category'],
      array: array,
    );
  }
}
