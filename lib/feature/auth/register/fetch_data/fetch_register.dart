import 'dart:convert';
import 'package:flutter_application_1/feature/auth/register/type/register_response.dart';
import 'package:http/http.dart';

Future<RegisterResponse> register(String email, String username,
    String password, String confirmPassword) async {
  final Response response = await post(
    Uri.parse('http://192.168.1.108:3000/api/v1/auth/register'),
    headers: <String, String>{
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '*/*'
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'username': username,
      'password': password,
      'confirmPassword': confirmPassword,
    }),
  );

  if (response.statusCode == 200) {
    return RegisterResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw response.body;
  }
}
