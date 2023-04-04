import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:telemetry/absensi/absensi_from_view.dart';
import 'package:telemetry/history/database/database_helper.dart';
import 'package:telemetry/history/history_form_view.dart';
import 'package:telemetry/history/model/history_model.dart';
import 'package:telemetry/history/service/cek_absen_service.dart';
import 'package:telemetry/history/service/history_delete_service.dart';
import 'package:telemetry/history/service/history_index_service.dart';
import 'package:telemetry/history/service/history_store_service.dart';

class HistoryIndexController extends GetxController {
  late final HistoryIndexService service;
  late final HistoryDeleteService deleteService;
  late final HistoryStoreService historyStoreService;
  late final CekAbsenService cekAbsenServicce;
  late HistoryModel model;
  late List<Map<String, dynamic>> localModel = [];
  var isDataLoading = false.obs;
  var connectionType = 0.obs;
  var tokens = ''.obs;
  final Connectivity connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    getConnectivityType();
    service = Get.put(HistoryIndexService());
    deleteService = Get.put(HistoryDeleteService());
    historyStoreService = Get.put(HistoryStoreService());
    cekAbsenServicce = Get.put(CekAbsenService());
    getData();
  }

  void getData() {
    isDataLoading(true);
    DatabaseHelper.instance.queryAllRows().then((value) {
      if (value.isNotEmpty) {
        if (connectionType.value == 0) {
          for (var element in value) {
            localModel.add({
              "historyId": element['historyId'],
              "statonId": element['statonId'],
              "assetId": element['assetId'],
              "title": element['title'],
              "body": element['body'],
              "file": element['file'],
            });
          }
        } else {
          for (var element in value) {
            var postval;
            if (element['file'] != '') {
              postval = FormData({
                "station": element['statonId'],
                "history_title": element['title'],
                "history_body": element['body'],
                "file": MultipartFile(File(element['file']),
                    filename: element['file'])
              });
            } else {
              postval = FormData({
                "station": element['statonId'],
                "history_title": element['title'],
                "history_body": element['body'],
              });
            }
            //print(postval);
            final response =
                historyStoreService.storeData(tokens.value, postval);
            if (response != null) {
              DatabaseHelper.instance.delete(element['historyId']);
              getData();
              getStationList(tokens.value);
            }
          }
        }
      } else {
        localModel = [];
      }
    });
    isDataLoading(false);
  }

  void daleteData(int id) async {
    await DatabaseHelper.instance.delete(id);
  }

  Future<void> getStationList(String token) async {
    isDataLoading(true);
    tokens(token);
    final response = await service.fecthData(token);
    isDataLoading(false);
    if (response != null) {
      model = response;
    } else {
      /// Show user a dialog about the error response
      model = HistoryModel(success: false, message: "Data Notfound", data: []);
      Get.defaultDialog(
          middleText: 'Data Not found',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }
  }

  Future<bool> cekAbsen(String token) async {
    var result = await cekAbsenServicce.getAbsen(token);
    return result;
  }

  Future<void> deleteData(String token, String id) async {
    await deleteService.deleteData(token, id);
  }

  Future<void> getConnectivityType() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return _updateState(connectivityResult);
  }

  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;

        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        break;
      default:
        break;
    }
  }
}
