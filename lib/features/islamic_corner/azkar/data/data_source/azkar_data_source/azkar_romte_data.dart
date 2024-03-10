import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../../../core/utils/app_constance.dart';
import '../../model/azkar_model/azkar_model.dart';

abstract class BaseAzkarRemoteDataJson {
  Future<List<AzkarModel>> getAllAzkar();
}

class AzkarRemoteDataJson implements BaseAzkarRemoteDataJson {
  @override
  Future<List<AzkarModel>> getAllAzkar() async {
    try {
      final response = await rootBundle.loadString(AppConstance.azkarJson);
      final jsonData = json.decode(response);
      List<AzkarModel> azkarList = [];

      for (var item in jsonData) {
        AzkarModel azkarModel = AzkarModel.fromJson(item);
        azkarList.add(azkarModel);
      }
      return azkarList;
    } catch (e) {
      return [];
    }
  }
}
