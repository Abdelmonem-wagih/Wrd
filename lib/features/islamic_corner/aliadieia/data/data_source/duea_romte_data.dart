import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../../core/utils/app_constance.dart';
import '../model/duea_model.dart';

abstract class BaseDueaRemoteDataJson {
  Future<List<DueaModel>> getAllAliadieia();
}

class DueaRemoteDataJson implements BaseDueaRemoteDataJson {
  @override
  Future<List<DueaModel>> getAllAliadieia() async {
    try {
      final response = await rootBundle.loadString(AppConstance.dueaJson);
      final jsonData = json.decode(response);
      List<DueaModel> dueaList = [];

      for (var item in jsonData) {
        DueaModel dueaModel = DueaModel.fromJson(item);
        dueaList.add(dueaModel);
      }
      return dueaList;
    } catch (e) {
      return [];
    }
  }
}
