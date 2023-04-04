import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:telemetry/constant.dart';

class HistoryEditService extends GetConnect {
  final String loginUrl = '${Constant.baseUrl}/api/stationHistory';

  Future<dynamic> editData(String token, String id, FormData postVal) async {
    final response = await post("$loginUrl/$id", postVal, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }
}
