import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemetry/absensi/model/absensi_index_model.dart';
import 'package:telemetry/absensi/model/absensi_store_model.dart';
import 'package:telemetry/absensi/service/absensi_index_service.dart';
import 'package:telemetry/history/history_form_view.dart';

class AbsensiIndexController extends GetxController {
  late final AbsensiIndexService service;
  late AbsensiIndexModel model;
  late AbsensiStoreModel storeResponse;
  late List<Map<String, dynamic>> localModel = [];
  var isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    service = Get.put(AbsensiIndexService());
  }

  void getData(String token) async {
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
    isDataLoading(false);
  }

  void storeData(String token, FormData postVal) async {
    isDataLoading(true);
    final response = await service.storeData(token, postVal);
    //print(response!.success);
    if (response!.success) {
      isDataLoading(false);
      Get.off(() => const HistoryFormView());
      storeResponse = response;
    } else {
      /// Show user a dialog about the error response
      Get.defaultDialog(
          middleText: 'Terjadi Kesalahan',
          textConfirm: 'Error',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }
    isDataLoading(false);
  }
}
