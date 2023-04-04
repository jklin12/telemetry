import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:telemetry/chart/model/hytrograph_model.dart';

import 'package:telemetry/constant.dart';

class HytrographService extends GetConnect {
  final String loginUrl = '${Constant.baseUrl}/api/hytrograph';

  Future<HytrographModel?> fecthData(
      String selectedDate, String station, String token) async {
    final response = await post(
        loginUrl, {'date': selectedDate, 'station': int.parse(station)},
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == HttpStatus.ok) {
      return HytrographModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
