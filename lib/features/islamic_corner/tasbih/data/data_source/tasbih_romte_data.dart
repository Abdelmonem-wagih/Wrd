import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../../core/utils/app_constance.dart';
import '../model/tasbih_model.dart';

abstract class BaseTasbihRemoteDataJson {
  Future<List<TasbihModel>> getAllTasbih();
}

class TasbihRemoteDataJson implements BaseTasbihRemoteDataJson {
  @override
  Future<List<TasbihModel>> getAllTasbih() async {
    try {
      final response = await rootBundle.loadString(AppConstance.tasbihJson);
      final jsonData = json.decode(response);
      List<TasbihModel> tasbihList = [];

      for (var item in jsonData) {
        TasbihModel tasbihModel = TasbihModel.fromJson(item);
        tasbihList.add(tasbihModel);
      }
      return tasbihList;
    } catch (e) {
      return [];
    }
  }
}
