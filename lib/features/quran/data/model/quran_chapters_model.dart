// ignore_for_file: must_be_immutable

import '../../domain/entities/quran_chapters.dart';

class QuranChaptersModel extends QuranChapters {
  QuranChaptersModel({
    required super.id,
    required super.revelationPlace,
    required super.nameSimple,
    required super.nameArabic,
    required super.versesCount,
   required super.pages,
  });

  factory QuranChaptersModel.fromJson(Map<String, dynamic> json) => QuranChaptersModel(
        id: json['id'],
        revelationPlace: json['revelation_place'],
        nameSimple: json['name_simple'],
        nameArabic: json['name_arabic'],
        versesCount: json['verses_count'],
        pages: json['pages'].cast<int>(),
      );
}
