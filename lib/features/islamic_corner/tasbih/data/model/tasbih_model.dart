// ignore_for_file: must_be_immutable

import '../../domain/entities/tasbih.dart';
import '../../domain/entities/tasbih_array.dart';
import 'tasbih_array_model.dart';

class TasbihModel extends Tasbih {
  TasbihModel(
      {required super.array, required super.id, required super.category});

  factory TasbihModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> arrayJson = json['array'];
    List<TasbihArray?> array = arrayJson
        .map((ayahJson) => TasbihArrayModel.fromJson(ayahJson))
        .toList();
    return TasbihModel(
      id: json["id"],
      category: json["category"],
      array: array,
    );
  }
}
