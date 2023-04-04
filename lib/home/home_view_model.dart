import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:telemetry/core/authentication_manager.dart';
import 'package:telemetry/core/logout_service.dart';
import 'package:telemetry/home/home_model.dart';
import 'package:telemetry/home/home_service.dart';

class HomeViewModel extends GetxController {
  late final HomeService service;
  late final LogoutService logoutService;
  final Connectivity connectivity = Connectivity();

  HomeModel? model;
  var isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    service = Get.put(HomeService());
    logoutService = Get.put(LogoutService());
  }

  Future<void> getData(AuthenticationManager authenticationManager) async {
    isDataLoading(true);
    final response = await service.fecthData(authenticationManager.getToken()!);

    getConnectivityType().then((value) {
      if (value != ConnectivityResult.none) {
        if (response != null) {
          isDataLoading(false);
          model = response;
        } else {
          Get.defaultDialog(
              title: "Unauthenticated",
              middleText: 'Please Login',
              textConfirm: 'OK',
              confirmTextColor: Colors.white,
              barrierDismissible: true,
              onConfirm: () {
                Get.back(closeOverlays: true);
                authenticationManager.logOut();
              });
        }
      } else {
        isDataLoading(false);
      }
    });
  }

  Future<void> deleteToken(AuthenticationManager authenticationManager) async {
    isDataLoading(true);

    await logoutService.logout(authenticationManager.getToken()!);
  }

  Future<ConnectivityResult> getConnectivityType() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return connectivityResult;
  }
}
