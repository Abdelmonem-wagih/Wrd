// ignore_for_file: must_be_immutable

import 'package:wrd/features/islamic_corner/azkar/data/model/azkar_model/array_model.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/entities/azkar_entities/azkar.dart';

import '../../../domain/entities/azkar_entities/azkar_array.dart';

class AzkarModel extends Azkar {
  AzkarModel(
      {required super.id, required super.array, required super.category});

  factory AzkarModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> arrayJson = json['array'];
    List<AzkarArray>? array =
        arrayJson.map((ayahJson) => ArrayModel.fromJson(ayahJson)).toList();
    return AzkarModel(
      id: json['id'],
      category: json['category'],
      array: array,
    );
  }
}
