import 'dart:convert';
import 'package:flutter_application_1/feature/auth/login/dto/login.dto.dart';
import 'package:http/http.dart';

Future<LoginDto> login(String username, String password) async {
  final response = await post(
    Uri.parse('http://192.168.1.108:3000/api/v1/auth/login'),
    headers: <String, String>{
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '*/*'
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    return LoginDto.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw response.body;
  }
}
