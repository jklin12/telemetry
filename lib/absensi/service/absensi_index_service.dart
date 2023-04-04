import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:telemetry/absensi/model/absensi_index_model.dart';
import 'package:telemetry/absensi/model/absensi_store_model.dart';
import 'package:telemetry/constant.dart';

class AbsensiIndexService extends GetConnect {
  final String loginUrl = '${Constant.baseUrl}/api/absen';

  Future<AbsensiIndexModel?> fecthData(String token) async {
    final response =
        await get("${loginUrl}", headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == HttpStatus.ok) {
      return AbsensiIndexModel.fromJson(response.body);
    } else {
      return null;
    }
  }

  Future<AbsensiStoreModel?> storeData(String token, FormData postval) async {
    final response = await post(
      "${loginUrl}",
      postval,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == HttpStatus.ok) {
      return AbsensiStoreModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
