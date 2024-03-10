// ignore_for_file: must_be_immutable
import 'package:wrd/features/islamic_corner/azkar/domain/entities/tashahhud_entities/tashahhud.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/entities/tashahhud_entities/tashahhud_array.dart';

import 'tahshhud_array_model.dart';

class TashahhudModel extends Tashahhud {
  TashahhudModel({
    required super.id,
    required super.category,
    required super.array,
  });

  factory TashahhudModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> arrayJson = json['array'];
    List<TashahhudArray?> array = arrayJson
        .map((ayahJson) => TashahhudArrayModel.fromJson(ayahJson))
        .toList();
    return TashahhudModel(
      id: json['id'],
      category: json['category'],
      array: array,
    );
  }
}
