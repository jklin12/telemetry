import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemetry/wire_vibration/model/wire_vibration_model.dart';
import 'package:telemetry/wire_vibration/service/wire_vibration_service.dart';

class WireVibrationViewModel extends GetxController {
  late final WireVirationService service;
  WireVibrationModel? model;
  var isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    service = Get.put(WireVirationService());
  }

  Future<void> getData(String selectedDate, String token) async {
    isDataLoading(true);
    final response = await service.fecthData(selectedDate, token);
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
