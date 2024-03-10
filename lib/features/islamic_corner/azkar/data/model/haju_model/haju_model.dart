// ignore_for_file: must_be_immutable

import 'package:wrd/features/islamic_corner/azkar/domain/entities/haju_entities/haju.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/entities/haju_entities/haju_array.dart';

import 'haju_array_model.dart';

class HajuModel extends Haju {
  HajuModel({
    required super.id,
    required super.category,
    required super.array,
  });

  factory HajuModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> arrayJson = json['array'];
    List<HajuArray>? array =
        arrayJson.map((ayahJson) => HajuArrayModel.fromJson(ayahJson)).toList();
    return HajuModel(
      id: json['id'],
      category: json['category'],
      array: array,
    );
  }
}
