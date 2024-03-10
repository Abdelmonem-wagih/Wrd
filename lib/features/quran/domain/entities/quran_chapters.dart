// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class QuranChapters extends Equatable {
  int? id;
  String? revelationPlace;
  String? nameSimple;
  String? nameArabic;
  int? versesCount;
  List<int>? pages;
  QuranChapters({
    required this.id,
    required this.revelationPlace,
    required this.nameSimple,
    required this.nameArabic,
    required this.versesCount,
    required this.pages,
  });

  @override
  List<Object?> get props => [
        id,
        revelationPlace,
        nameSimple,
        nameArabic,
        versesCount,
        pages,
      ];
}
