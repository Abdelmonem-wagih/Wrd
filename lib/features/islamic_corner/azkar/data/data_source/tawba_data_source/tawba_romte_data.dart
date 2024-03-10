import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../../../core/utils/app_constance.dart';
import '../../model/tawba_model/tawba_model.dart';

abstract class BaseTawbaRemoteDataJson {
  Future<List<TawbaModel>> getAllTawba();
}

class TawbaRemoteDataJson implements BaseTawbaRemoteDataJson {
  @override
  Future<List<TawbaModel>> getAllTawba() async {
    try {
      final response = await rootBundle.loadString(AppConstance.tawbaJson);
      final jsonData = json.decode(response);
      List<TawbaModel> tawbaList = [];

      for (var item in jsonData) {
        TawbaModel tawbaModel = TawbaModel.fromJson(item);
        tawbaList.add(tawbaModel);
      }
      return tawbaList;
    } catch (e) {
      return [];
    }
  }
}
