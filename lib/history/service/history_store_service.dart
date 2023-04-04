import 'package:flutter/foundation.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:telemetry/constant.dart';

class HistoryStoreService extends GetConnect {
  final String loginUrl = '${Constant.baseUrl}/api/stationHistory';

  Future<dynamic> storeData(String token, FormData postVal) async {
    final response = await post(loginUrl, postVal, headers: {
      'Authorization': 'Bearer $token',
    });
    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }
}
