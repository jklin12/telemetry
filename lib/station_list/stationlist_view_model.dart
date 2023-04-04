import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemetry/map.dart/map_marker.dart';
import 'package:telemetry/station_list/database/station_database.dart';
import 'package:telemetry/station_list/model/stationlist_response_model.dart';
import 'package:telemetry/station_list/service/stationlist_service.dart';
import 'package:latlong2/latlong.dart';

class StationListViewModel extends GetxController {
  late final StationListService stationListService;
  StationListResponseModel? stationListResponseModel;
  List<MapMarker> mapMarker = [];
  var isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    stationListService = Get.put(StationListService());
  }

  Future<void> getStationList(String token) async {
    isDataLoading(true);
    final response = await stationListService.fecthData(token);
    if (response != null) {
      stationListResponseModel = response;
      StationDatabase.instance.clearTable();
      for (var element in response.data!) {
        mapMarker.add(MapMarker(
            image: 'assets/images/telemetry.png',
            title: element.stationName,
            address: element.stationRiver,
            equipment: element.stationEquipment,
            productYear: element.stationProdYear,
            guadrsman: element.stationGuardsman,
            location: LatLng(element.stationLat!, element.stationLong!),
            rating: 4));
      }
      for (var element in response.data!) {
        addData({
          "stationId": element.stationId,
          "station_name": element.stationName
        });
      }

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

  void addData(Map<String, dynamic> postval) async {
    await StationDatabase.instance.insert(postval);
  }
}
