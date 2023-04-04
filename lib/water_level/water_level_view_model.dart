import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemetry/water_level/model/water_level_model.dart';
import 'package:telemetry/water_level/service/water_level_service.dart';

class WaterLevelViewModel extends GetxController {
  late final WaterLevelService service;
  WaterLevelModel? model;
  var isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    service = Get.put(WaterLevelService());
  }

  Future<void> getData(
      String selectedDate, String stationId, String token) async {
    isDataLoading(true);
    final response = await service.fecthData(selectedDate, stationId, token);
    if (response != null) {
      isDataLoading(false);
      model = response;
    } else {
      /// Show user a dialog about the error response
      Get.defaultDialog(
          middleText: 'Data Not found',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }
  }
}
