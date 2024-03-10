// ignore_for_file: must_be_immutable
import 'package:wrd/features/islamic_corner/azkar/domain/entities/says_entities/says.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/entities/says_entities/says_array.dart';

import 'says_array_model.dart';

class SaysModel extends Says {
  SaysModel({
    required super.id,
    required super.category,
    required super.array,
  });

  factory SaysModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> arrayJson = json['array'];
    List<SaysArray>? array =
        arrayJson.map((ayahJson) => SaysArrayModel.fromJson(ayahJson)).toList();
    return SaysModel(
      id: json['id'],
      category: json['category'],
      array: array,
    );
  }
}
