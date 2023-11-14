import 'dart:convert';
import 'package:flutter_application_1/feature/auth/register_otp/type/send_otp_response.dart';
import 'package:flutter_application_1/global/utils/fetch.dart';
import 'package:http/http.dart';

Future<SendOtpResponse> sendOtp(String token, String otp) async {
  final Response response = await putApi(
    url: 'auth/update-status/$token',
    body: {"otp": otp},
  );

  if (response.statusCode == 200) {
    return SendOtpResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw response.body;
  }
}
