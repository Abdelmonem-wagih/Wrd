import 'package:dio/dio.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/network/error_message_model.dart';
import 'package:wrd/features/quran/data/model/quranAudio/rewaya_model.dart';

import '../../../../core/utils/app_constance.dart';

abstract class BaseRewayatRemoteData {
  Future<List<RewayaModel>> geRewayat();
}

class RewayatRemoteDataDio implements BaseRewayatRemoteData {
  final Dio dio = Dio();
  @override
  Future<List<RewayaModel>> geRewayat() async {
    final response = await dio.get(
      AppConstance.rewayat,
    );
    if (response.statusCode == 200) {
      final dataRespose = List<RewayaModel>.from(
          (response.data['riwayat'] as List)
              .map((e) => RewayaModel.fromJson(e)));
      return dataRespose;
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromjson(response.data));
    }
  }
}
