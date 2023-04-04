import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/water_level/model/water_level_model.dart';

class WaterLevelService extends GetConnect {
  final String loginUrl = '${Constant.baseUrl}/api/waterLevel';

  Future<WaterLevelModel?> fecthData(
      String selectedDate, String stationId, String token) async {
    final response = await get(loginUrl,
        headers: {'Authorization': 'Bearer $token'},
        query: {"date": selectedDate});
    if (response.statusCode == HttpStatus.ok) {
      return WaterLevelModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
