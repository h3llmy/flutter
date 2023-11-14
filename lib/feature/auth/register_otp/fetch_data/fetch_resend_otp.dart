import 'dart:convert';
import 'package:flutter_application_1/feature/auth/register_otp/type/resend_otp_response.dart';
import 'package:flutter_application_1/global/utils/fetch.dart';
import 'package:http/http.dart';

Future<ResendOtpResponse> resendOtp(String token) async {
  final Response response = await putApi(url: 'auth/resend-otp/$token');

  if (response.statusCode == 200) {
    return ResendOtpResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw response.body;
  }
}
