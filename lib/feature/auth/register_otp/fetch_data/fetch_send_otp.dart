import 'dart:convert';
import 'package:flutter_application_1/feature/auth/register_otp/type/send_otp_response.dart';
import 'package:http/http.dart';

Future<SendOtpResponse> sendOtp(String token, String otp) async {
  final Response response = await put(
    Uri.parse('http://192.168.1.108:3000/api/v1/auth/update-status/$token'),
    headers: <String, String>{
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '*/*'
    },
    body: jsonEncode(<String, String>{"otp": otp}),
  );

  if (response.statusCode == 200) {
    return SendOtpResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw response.body;
  }
}
