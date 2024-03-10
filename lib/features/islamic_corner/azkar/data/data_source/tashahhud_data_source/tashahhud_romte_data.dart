import 'dart:convert';

import 'package:flutter/services.dart';

import '../../model/tashahhud_model/tashahhud_model.dart';

import '../../../../../../core/utils/app_constance.dart';

abstract class BaseTashahhudRemoteDataJson {
  Future<List<TashahhudModel>> getAllTashahhud();
}

class TashahhudRemoteDataJson implements BaseTashahhudRemoteDataJson {
  @override
  Future<List<TashahhudModel>> getAllTashahhud() async {
    try {
      final response = await rootBundle.loadString(AppConstance.tashahhudJson);
      final jsonData = json.decode(response);
      List<TashahhudModel> tashahhudList = [];

      for (var item in jsonData) {
        TashahhudModel tashahhudModel = TashahhudModel.fromJson(item);
        tashahhudList.add(tashahhudModel);
      }
      return tashahhudList;
    } catch (e) {
      return [];
    }
  }
}
