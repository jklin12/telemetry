import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/station_list/model/stationlist_response_model.dart';

class StationListService extends GetConnect {
  final String loginUrl = '${Constant.baseUrl}/api/stationList';

  Future<StationListResponseModel?> fecthData(String token) async {
    final response =
        await get(loginUrl, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == HttpStatus.ok) {
      return StationListResponseModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
