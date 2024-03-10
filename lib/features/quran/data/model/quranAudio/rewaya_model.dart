import 'package:wrd/features/quran/domain/entities/quranAudio/rewaya.dart';

// ignore: must_be_immutable
class RewayaModel extends Rewaya {
  RewayaModel({
    required super.id,
    required super.name,
  });

  factory RewayaModel.fromJson(Map<String, dynamic> json) => RewayaModel(
        id: json['id'],
        name: json['name'],
      );
}
