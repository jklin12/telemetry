import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemetry/rainfall/model/daily_rainfall_req_model.dart';
import 'package:telemetry/rainfall/model/rainfall_bystation_model.dart';
import 'package:telemetry/rainfall/service/rainfall_bystation_service.dart';
import 'package:telemetry/station_list/model/stationlist_response_model.dart';

class RainfallBystationViewModel extends GetxController {
  late final RainfallBystationService service;
  RainfallByStationModel? model;
  StationListResponseModel? station;

  var isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    service = Get.put(RainfallBystationService());
  }

  Future<void> getDailyRainfall(
      String selectedDate, String selectedStation, String token) async {
    isDataLoading(true);
    final response = await service.fecthData(
        DailyRainfallReqModel(date: selectedDate, station: selectedStation),
        token);
    final stations = await service.fecthStation(token);
    if (response != null) {
      isDataLoading(false);
      model = response;
      station = stations;
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
