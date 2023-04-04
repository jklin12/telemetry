import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemetry/flow/model/flow_model.dart';
import 'package:telemetry/flow/service/flow_service.dart';

class FlowViewModel extends GetxController {
  late final FlowService service;
  FlowModel? model;
  var isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    service = Get.put(FlowService());
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
