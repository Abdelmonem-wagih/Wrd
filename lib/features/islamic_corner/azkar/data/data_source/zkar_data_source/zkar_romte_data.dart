import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../../../core/utils/app_constance.dart';
import '../../model/zkar_model/zkar_model.dart';

abstract class BaseZkarRemoteDataJson {
  Future<List<ZkarModel>> getAllZkar();
}

class ZkarRemoteDataJson implements BaseZkarRemoteDataJson {
  @override
  Future<List<ZkarModel>> getAllZkar() async {
    try {
      final response = await rootBundle.loadString(AppConstance.zkarJson);
      final jsonData = json.decode(response);
      List<ZkarModel> zkarList = [];

      for (var item in jsonData) {
        ZkarModel zkarModel = ZkarModel.fromJson(item);
        zkarList.add(zkarModel);
      }
      return zkarList;
    } catch (e) {
      return [];
    }
  }
}
