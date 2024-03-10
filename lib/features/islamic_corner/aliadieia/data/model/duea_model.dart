// ignore_for_file: must_be_immutable

import 'package:wrd/features/islamic_corner/aliadieia/domain/entities/duea.dart';

import '../../domain/entities/duea_array.dart';
import 'duea_array_model.dart';

class DueaModel extends Duea {
  DueaModel({required super.id, required super.array, required super.category});

  factory DueaModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> arrayJson = json['array'];
    List<DueaArray?> array =
    arrayJson.map((ayahJson) => DueaArrayModel.fromJson(ayahJson)).toList();
    return DueaModel(
      id: json['id'],
      category: json['category'],
      array: array,
    );
  }
}
