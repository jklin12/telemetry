import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:telemetry/history/database/database_helper.dart';
import 'package:telemetry/history/history_index_view.dart';
import 'package:telemetry/history/model/history_db_model.dart';
import 'package:telemetry/history/service/history_edit_service.dart';
import 'package:telemetry/history/service/history_store_service.dart';
import 'package:telemetry/station_list/database/station_database.dart';
import 'package:telemetry/station_list/model/stationlist_response_model.dart';
import 'package:telemetry/station_list/service/stationlist_service.dart';

class HistoryFormController extends GetxController {
  late final StationListService stationListService;
  late final HistoryStoreService historyStoreService;
  late final HistoryEditService historyEditService;
  final Connectivity connectivity = Connectivity();
  late StationListResponseModel stationListResponseModel;
  late List<Map<String, dynamic>> localStation = [];
  late StreamSubscription streamSubscription;

  var isDataLoading = false.obs;
  var isStoreLoading = false.obs;
  var connectionType = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getConnectivityType();
    streamSubscription =
        connectivity.onConnectivityChanged.listen(_updateState);
    stationListService = Get.put(StationListService());
    historyStoreService = Get.put(HistoryStoreService());
    historyEditService = Get.put(HistoryEditService());
  }

  Future<void> getStationList(String token) async {
    isDataLoading(true);
    final response = await stationListService.fecthData(token);
    isDataLoading(false);
    if (response != null) {
      stationListResponseModel = response;
    } else {
      stationListResponseModel = StationListResponseModel();
      /*Get.defaultDialog(
          middleText: 'Data Not found',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });*/
    }
  }

  Future<void> storeHistory(String token, FormData postval) async {
    isStoreLoading(true);
    if (connectionType.value == 0) {
      isStoreLoading(false);
      addData(HistoryDbModel(
          statonId: int.parse(postval.fields[0].value),
          assetId: 3,
          title: postval.fields[1].value,
          body: postval.fields[2].value,
          file: postval.fields.length == 4 ? postval.fields[3].value : ''));

      Get.off(() => const HistoryIndexView());
      //Get.back(result: 'success');
    } else {
      final response = await historyStoreService.storeData(token, postval);
      if (response != null) {
        isStoreLoading(false);
        if (response) {
          Get.off(() => const HistoryIndexView());
        }
      } else {
        /// Show user a dialog about the error response

        addData(HistoryDbModel(
            statonId: int.parse(postval.fields[0].value),
            assetId: 3,
            title: postval.fields[1].value,
            body: postval.fields[2].value,
            file: postval.length == 4 ? postval.fields[3].value : ''));
        Get.defaultDialog(
            middleText: 'Data akan diupload nanti',
            textConfirm: 'Gagal',
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.back(result: 'success');
            });
      }
    }
  }

  Future<void> editHistory(String token, String id, FormData postval) async {
    isStoreLoading(true);
    final response = await historyEditService.editData(token, id, postval);
    if (response != null) {
      isStoreLoading(false);
      if (response) {
        Get.back(result: 'success');
      }
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

  Future<List<Map<String, dynamic>>> getLocalStation() async {
    isStoreLoading(true);
    await StationDatabase.instance.queryAllRows().then((value) {
      for (var element in value) {
        localStation.add({
          "stationId": element['stationId'],
          "station_name": element['station_name']
        });
      }
    });
    isStoreLoading(false);
    return localStation;
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

  void addData(HistoryDbModel postval) async {
    await DatabaseHelper.instance.insert(postval);
  }

  @override
  void onClose() {
    streamSubscription.cancel();
  }
}
