import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../../../core/utils/app_constance.dart';
import '../../model/says_model/says_model.dart';

abstract class BaseSaysRemoteDataJson {
  Future<List<SaysModel>> getAllSays();
}

class SaysRemoteDataJson implements BaseSaysRemoteDataJson {
  @override
  Future<List<SaysModel>> getAllSays() async {
    try {
      final response = await rootBundle.loadString(AppConstance.saysJson);
      final jsonData = json.decode(response);
      List<SaysModel> saysList = [];

      for (var item in jsonData) {
        SaysModel saysModel = SaysModel.fromJson(item);
        saysList.add(saysModel);
      }
      return saysList;
    } catch (e) {
      return [];
    }
  }
}
