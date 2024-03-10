import 'package:dio/dio.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/network/error_message_model.dart';

import '../../../../core/utils/app_constance.dart';
import '../model/quran_chapters_model.dart';

abstract class BaseQuranChaptersRemoteData {
  Future<List<QuranChaptersModel>> getQuranChapters();
}

class QuranChaptersRemoteDataDio implements BaseQuranChaptersRemoteData {
  final Dio dio = Dio();
  @override
  Future<List<QuranChaptersModel>> getQuranChapters() async {
    final response = await dio.get(AppConstance.quranChaptersApi);
    if (response.statusCode == 200) {
      final dataResponse = List<QuranChaptersModel>.from(
          (response.data['chapters'] as List)
              .map((e) => QuranChaptersModel.fromJson(e)));
      return dataResponse;
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromjson(response.data),
      );
    }
  }
}
