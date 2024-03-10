import 'package:dio/dio.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/network/error_message_model.dart';

import '../../../../core/utils/app_constance.dart';
import '../model/quranAudio/quran_audio_model.dart';

abstract class BaseQuranAudioRemoteData {
  Future<List<QuranAudioModel>> getQuranAudio({int? rewaya});
}

class QuranAudioRemoteDataDio implements BaseQuranAudioRemoteData {
  final Dio dio = Dio();
  @override
  Future<List<QuranAudioModel>> getQuranAudio({int? rewaya}) async {
    final response = await dio.get(
      AppConstance.quranAudio,
      queryParameters: {'rewaya': rewaya},
    );
    if (response.statusCode == 200) {
      final dataRespose = List<QuranAudioModel>.from(
          (response.data['reciters'] as List)
              .map((e) => QuranAudioModel.fromJson(e)));
      return dataRespose;
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromjson(response.data));
    }
  }
}
