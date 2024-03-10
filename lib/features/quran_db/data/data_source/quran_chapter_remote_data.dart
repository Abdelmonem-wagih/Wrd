import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../../core/utils/app_constance.dart';
import '../model/quran_chapter_model.dart';
abstract class BaseQuranChapterRemoteData {
  Future<List<QuranChapterModel>> fetchQuranChapters();
}

class QuranChapterJsonRemoteDataDio implements BaseQuranChapterRemoteData {
  @override
  Future<List<QuranChapterModel>> fetchQuranChapters() async {
    try {
      // Load the JSON file from the assets folder
      String jsonString = await rootBundle.loadString(AppConstance.quranChapter);
      List<dynamic> jsonList = json.decode(jsonString)['chapters'];

      // Convert JSON data to a list of Chapter objects
      List<QuranChapterModel> chapters =
      jsonList.map((json) => QuranChapterModel.fromJson(json)).toList();

      return chapters;
    } catch (e) {
      throw Exception("Failed to load chapters: $e");
    }
  }
}
