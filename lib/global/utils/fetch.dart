import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<http.Response> getApi({required String url}) async {
  final String? baseUrl = dotenv.env['BASE_API_URL'];
  if (baseUrl != null) {
    return http.get(Uri.parse(baseUrl + url), headers: {
      "Content-Type": "application/json",
    }).timeout(const Duration(seconds: 60 * 2));
  } else {
    throw Exception('BASE_API_URL is not defined in .env file.');
  }
}

Future<http.Response> postApi({required String url, Object? body}) async {
  final String? baseUrl = dotenv.env['BASE_API_URL'];
  print(baseUrl);
  if (baseUrl != null) {
    return await http.post(Uri.parse(baseUrl + url),
        body: body == null ? null : jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
        }).timeout(const Duration(seconds: 60 * 2));
  } else {
    throw Exception('BASE_API_URL is not defined in .env file.');
  }
}

Future<http.Response> putApi({required String url, Object? body}) async {
  final String? baseUrl = dotenv.env['BASE_API_URL'];
  if (baseUrl != null) {
    return http.put(Uri.parse(baseUrl + url),
        body: body == null ? null : jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
        }).timeout(const Duration(seconds: 60 * 2));
  } else {
    throw Exception('BASE_API_URL is not defined in .env file.');
  }
}

Future<http.Response> patchApi({required String url, Object? body}) async {
  final String? baseUrl = dotenv.env['BASE_API_URL'];
  if (baseUrl != null) {
    return http.patch(Uri.parse(baseUrl + url),
        body: body == null ? null : jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
        }).timeout(const Duration(seconds: 60 * 2));
  } else {
    throw Exception('BASE_API_URL is not defined in .env file.');
  }
}

Future<http.Response> deleteApi({required String url, Object? body}) async {
  final String? baseUrl = dotenv.env['BASE_API_URL'];
  if (baseUrl != null) {
    return http.delete(Uri.parse(baseUrl + url),
        body: body == null ? null : jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
        }).timeout(const Duration(seconds: 60 * 2));
  } else {
    throw Exception('BASE_API_URL is not defined in .env file.');
  }
}
