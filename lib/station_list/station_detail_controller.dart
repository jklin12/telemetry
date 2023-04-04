import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemetry/station_list/model/station_detail_model.dart';
import 'package:telemetry/station_list/service/station_detail_service.dart';

class StationDetailController extends GetxController {
  late final StationDetailService service;
  StationDetailModel? model;
  var isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    service = Get.put(StationDetailService());
  }

  Future<void> getStationList(String token, String stationId) async {
    isDataLoading(true);
    final response = await service.fecthData(token, stationId);
    if (response != null) {
      model = response;
      //print(response.data.station.stationTypes.length);
      isDataLoading(false);
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
