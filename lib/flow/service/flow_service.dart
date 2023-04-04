import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/flow/model/flow_model.dart';

class FlowService extends GetConnect {
  final String loginUrl = '${Constant.baseUrl}/api/flow';

  Future<FlowModel?> fecthData(String selectedDate, String token) async {
    final response = await get(loginUrl,
        headers: {'Authorization': 'Bearer $token'},
        query: {"date": selectedDate});
    if (response.statusCode == HttpStatus.ok) {
      return FlowModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
