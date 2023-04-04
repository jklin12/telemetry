import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/rainfall/model/daily_rainfall_model.dart';

class DailyRainfallService extends GetConnect {
  final String loginUrl = '${Constant.baseUrl}/api/dailyRainFall';

  Future<DailyRainfallModel?> fecthData(String date, String token) async {
    final response = await get(loginUrl, headers: {
      'Authorization': 'Bearer $token',
    }, query: {
      "date": date
    });

    if (response.statusCode == HttpStatus.ok) {
      //print(response.body['data']['station']);
      return DailyRainfallModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
