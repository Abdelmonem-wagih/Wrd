// ignore_for_file: must_be_immutable

import 'package:wrd/features/islamic_corner/azkar/data/model/tawba_model/tawba_array_model.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/entities/tawba_entities/tawba.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/entities/tawba_entities/tawba_array.dart';

class TawbaModel extends Tawba {
  TawbaModel({
    required super.id,
    required super.category,
    required super.array,
  });

  factory TawbaModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> arrayJson = json['array'];
    List<TawbaArray>? array = arrayJson
        .map((ayahJson) => TawbaArrayModel.fromJson(ayahJson))
        .toList();
    return TawbaModel(
      id: json['id'],
      category: json['category'],
      array: array,
    );
  }
}
