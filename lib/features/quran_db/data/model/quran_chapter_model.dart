// ignore_for_file: must_be_immutable



import '../../domain/entities/quran_chapter.dart';

class QuranChapterModel extends QuranChapter {
  QuranChapterModel({
    required super.id,
    required super.revelationPlace,
    required super.nameSimple,
    required super.nameArabic,
    required super.versesCount,
    required super.pages,
  });

  factory QuranChapterModel.fromJson(Map<String, dynamic> json) => QuranChapterModel(
    id: json['id'],
    revelationPlace: json['revelation_place'],
    nameSimple: json['name_simple'],
    nameArabic: json['name_arabic'],
    versesCount: json['verses_count'],
    pages: json['pages'].cast<int>(),
  );
}
