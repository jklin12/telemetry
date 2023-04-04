import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemetry/rainfall/model/curent_rainfall_model.dart';
import 'package:telemetry/rainfall/service/curent_rainfall_service.dart';

class CurentRainfallViewModel extends GetxController {
  late final CurentRainfallService service;
  CurentRainfallModel? model;
  var isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    service = Get.put(CurentRainfallService());
  }

  Future<void> getDailyRainfall(String token) async {
    isDataLoading(true);
    final response = await service.fecthData(token);
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
