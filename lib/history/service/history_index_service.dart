import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/history/model/history_model.dart';

class HistoryIndexService extends GetConnect {
  final String loginUrl = '${Constant.baseUrl}/api/stationHistory';

  Future<HistoryModel?> fecthData(String token) async {
    final response =
        await get(loginUrl, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == HttpStatus.ok) {
      return HistoryModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
