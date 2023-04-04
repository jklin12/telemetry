import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:telemetry/constant.dart';

class LogoutService extends GetConnect {
  final String loginUrl = '${Constant.baseUrl}/api/logout';

  Future<bool> logout(String token) async {
    final response =
        await get(loginUrl, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }
}
