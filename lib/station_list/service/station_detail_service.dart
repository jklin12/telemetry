import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/station_list/model/station_detail_model.dart';

class StationDetailService extends GetConnect {
  final String loginUrl = '${Constant.baseUrl}/api/station';

  Future<StationDetailModel?> fecthData(String token, String stationId) async {
    final response = await get("$loginUrl/$stationId",
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == HttpStatus.ok) {
      return StationDetailModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
