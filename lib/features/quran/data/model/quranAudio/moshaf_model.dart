import 'package:wrd/features/quran/domain/entities/quranAudio/moshaf.dart';

// ignore: must_be_immutable
class MoshafModel extends Moshaf {
  MoshafModel({
    required super.id,
    required super.name,
    required super.server,
    required super.surahList,
    required super.surahTotal,
  });

  factory MoshafModel.fromJson(Map<String, dynamic> json) => MoshafModel(
      id: json['id'],
      name: json['name'],
      server: json['server'],
      surahList: json['surah_list'],
      surahTotal: json['surah_total']);
}
