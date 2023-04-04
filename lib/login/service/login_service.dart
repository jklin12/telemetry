import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:telemetry/login/model/login_request_model.dart';
import 'package:telemetry/login/model/login_response_model.dart';

import '../../constant.dart';

class LoginService extends GetConnect {
  final String loginUrl = '${Constant.baseUrl}/api/login';

  Future<LoginResponseModel?> fetchLogin(LoginRequestModel model) async {
    final response = await post(loginUrl, model.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
