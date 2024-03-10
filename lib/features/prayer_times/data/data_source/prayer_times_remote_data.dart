// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/network/error_message_model.dart';
import 'package:wrd/core/utils/app_constance.dart';
import 'package:wrd/core/utils/app_string.dart';
import '../../presentoin/widgets/calender/menu_calender_hijir.dart';
import '../model/prayer_times_model/prayer_times_model.dart';

abstract class BasePrayerTimesRemoteData {
  Future<List<PrayerTimesModel>> getPrayerTimes();
}

class PrayerTimesRemoteDataDio implements BasePrayerTimesRemoteData {
  var hijir = HijriCalendar.now();
  final Dio dio = Dio();

  @override
  Future<List<PrayerTimesModel>> getPrayerTimes() async {
    AppString.imageName = AppConstance().getImage(AppString.Dhuhr);
    String data = AppConstance().prayerTimesApi(
      hijir.hYear,
      CalanderContcetWiget.numberMonthr == 0
          ? hijir.hMonth
          : CalanderContcetWiget.numberMonthr,
    );

    final response = await dio.get(data);
    if (response.statusCode == 200) {
      final dataResponse = List<PrayerTimesModel>.from(
          (response.data['data'] as List)
              .map((e) => PrayerTimesModel.fromJson(e)));

      return dataResponse;
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromjson(response.data),
      );
    }
  }
}
