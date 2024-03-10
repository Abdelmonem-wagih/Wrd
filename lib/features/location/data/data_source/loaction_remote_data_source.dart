// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/network/error_message_model.dart';
import 'package:wrd/core/utils/app_constance.dart';
import '../model/location_model.dart';

abstract class BaseLocationRemoteData {
  Future<List<LocationModel>> getLocation(double latitude, double longitude);
}

class LocationRemoteDataDio implements BaseLocationRemoteData {
  final Dio dio = Dio();

  @override
  Future<List<LocationModel>> getLocation(double latitude, double longitude) async {
    final response = await dio
        .get('${AppConstance.baseLocation}lat=$latitude&lon=$longitude');
    if (response.statusCode == 200) {
      final dataResponse = LocationModel.fromJson(response.data); // Parse the response directly to LocationModel
      return [dataResponse];
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromjson(response.data),
      );
    }
  }
}
