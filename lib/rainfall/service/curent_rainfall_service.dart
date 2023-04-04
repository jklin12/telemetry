import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/rainfall/model/curent_rainfall_model.dart';

class CurentRainfallService extends GetConnect {
  final String loginUrl = '${Constant.baseUrl}/api/curentRainFall';

  Future<CurentRainfallModel?> fecthData(String token) async {
    final response = await get(
      loginUrl,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == HttpStatus.ok) {
      return CurentRainfallModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
