import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemetry/chart/model/hytrograph_model.dart';
import 'package:telemetry/chart/service/hytrograph_service.dart';

class ChartHytrographViewModel extends GetxController {
  late final HytrographService service;
  HytrographModel? model;
  var isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    service = Get.put(HytrographService());
  }

  Future<void> getData(
      String selectedDate, String station, String token) async {
    isDataLoading(true);
    final response = await service.fecthData(selectedDate, station, token);
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
