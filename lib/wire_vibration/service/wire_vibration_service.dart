import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/wire_vibration/model/wire_vibration_model.dart';

class WireVirationService extends GetConnect {
  final String loginUrl = '${Constant.baseUrl}/api/wireVibration';

  Future<WireVibrationModel?> fecthData(
      String selectedDate, String token) async {
    final response = await get(loginUrl,
        headers: {'Authorization': 'Bearer $token'},
        query: {"date": selectedDate});
    if (response.statusCode == HttpStatus.ok) {
      return WireVibrationModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
