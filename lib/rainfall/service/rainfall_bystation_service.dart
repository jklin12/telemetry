import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/rainfall/model/daily_rainfall_req_model.dart';
import 'package:telemetry/rainfall/model/rainfall_bystation_model.dart';
import 'package:telemetry/station_list/model/stationlist_response_model.dart';

class RainfallBystationService extends GetConnect {
  final String loginUrl = '${Constant.baseUrl}/api/rainfallByStation';

  Future<RainfallByStationModel?> fecthData(
      DailyRainfallReqModel model, String token) async {
    final response = await get(loginUrl,
        headers: {
          'Authorization': 'Bearer $token',
        },
        query: model.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return RainfallByStationModel.fromJson(response.body);
    } else {
      return null;
    }
  }

  Future<StationListResponseModel?> fecthStation(String token) async {
    final response = await get('${Constant.baseUrl}/api/stationList',
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == HttpStatus.ok) {
      return StationListResponseModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
