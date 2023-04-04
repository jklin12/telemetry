import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:telemetry/constant.dart';
import 'package:telemetry/home/home_model.dart';

class HomeService extends GetConnect {
  final String loginUrl = '${Constant.baseUrl}/api/user';

  Future<HomeModel?> fecthData(String token) async {
    final response = await get(loginUrl, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });
    if (response.statusCode == HttpStatus.ok) {
      return HomeModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
