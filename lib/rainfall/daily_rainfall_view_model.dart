import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemetry/rainfall/model/daily_rainfall_model.dart';
import 'package:telemetry/rainfall/service/daily_rainfall_service.dart';

class DailyRainfallViewModel extends GetxController {
  late final DailyRainfallService dailyRainfallService;
  DailyRainfallModel? dailyRainfallModel;
  var isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    dailyRainfallService = Get.put(DailyRainfallService());
  }

  Future<void> getDailyRainfall(String date, String token) async {
    isDataLoading(true);
    final response = await dailyRainfallService.fecthData(date, token);
    if (response != null) {
      isDataLoading(false);
      dailyRainfallModel = response;
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
