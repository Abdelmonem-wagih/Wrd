import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../../../core/utils/app_constance.dart';
import '../../model/haju_model/haju_model.dart';

abstract class BaseHajuRemoteDataJson {
  Future<List<HajuModel>> getAllHaju();
}

class HajuRemoteDataJson implements BaseHajuRemoteDataJson {
  @override
  Future<List<HajuModel>> getAllHaju() async {
    try {
      final response = await rootBundle.loadString(AppConstance.hajuJson);
      final jsonData = json.decode(response);
      List<HajuModel> hajuList = [];

      for (var item in jsonData) {
        HajuModel hajuModel = HajuModel.fromJson(item);
        hajuList.add(hajuModel);
      }
      return hajuList;
    } catch (e) {
      return [];
    }
  }
}
