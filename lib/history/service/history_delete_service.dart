import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:telemetry/constant.dart';

class HistoryDeleteService extends GetConnect {
  final String loginUrl = '${Constant.baseUrl}/api/stationHistory';

  Future<dynamic> deleteData(String token, String id) async {
    final response = await delete("$loginUrl/$id", headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }
}
