import 'dart:convert';
import 'package:flutter_application_1/feature/auth/login/type/login_response.dart';
import 'package:flutter_application_1/global/utils/fetch.dart';
import 'package:http/http.dart';

Future<LoginResponse> login(String username, String password) async {
  final Response response = await postApi(
    url: 'auth/login',
    body: {
      'username': username,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    return LoginResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw response.body;
  }
}
