// ignore_for_file: must_be_immutable
import '../../../domain/entities/says_entities/says_array.dart';

class SaysArrayModel extends SaysArray {
  SaysArrayModel({
    required super.id,
    required super.text,
    required super.count,
    required super.repeat,
  });

  factory SaysArrayModel.fromJson(Map<String, dynamic> json) => SaysArrayModel(
        id: json['id'],
        text: json['text'],
        count: json['count'],
        repeat: json['repeat'],
      );
}
