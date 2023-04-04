import 'package:get/get_connect/connect.dart';
import 'package:telemetry/constant.dart';

class CekAbsenService extends GetConnect {
  final String loginUrl = '${Constant.baseUrl}/api/absen/cek';

  Future<dynamic> getAbsen(String token) async {
    final response = await get(loginUrl, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.body['data']['status']) {
      return true;
    } else {
      return false;
    }
  }
}
