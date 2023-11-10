import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<http.Response> get(String url) async {
  final baseUrl = dotenv.env['BASE_API_URL'];
  if (baseUrl != null) {
    return http.get(Uri.parse(baseUrl + url), headers: {
      "Content-Type": "application/json",
    }).timeout(const Duration(seconds: 60 * 2));
  } else {
    throw Exception('BASE_API_URL is not defined in .env file.');
  }
}

Future<http.Response> post(String url, Object body) async {
  final baseUrl = dotenv.env['BASE_API_URL'];
  if (baseUrl != null) {
    return await http
        .post(Uri.parse(baseUrl + url), body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
    }).timeout(const Duration(seconds: 60 * 2));
  } else {
    throw Exception('BASE_API_URL is not defined in .env file.');
  }
}

Future<http.Response> put(String url, Object body) async {
  final baseUrl = dotenv.env['BASE_API_URL'];
  if (baseUrl != null) {
    return http.put(Uri.parse(baseUrl + url), body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
    }).timeout(const Duration(seconds: 60 * 2));
  } else {
    throw Exception('BASE_API_URL is not defined in .env file.');
  }
}

Future<http.Response> patch(String url, Object body) async {
  final baseUrl = dotenv.env['BASE_API_URL'];
  if (baseUrl != null) {
    return http
        .patch(Uri.parse(baseUrl + url), body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
    }).timeout(const Duration(seconds: 60 * 2));
  } else {
    throw Exception('BASE_API_URL is not defined in .env file.');
  }
}

Future<http.Response> delete(String url, Object body) async {
  final baseUrl = dotenv.env['BASE_API_URL'];
  if (baseUrl != null) {
    return http
        .delete(Uri.parse(baseUrl + url), body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
    }).timeout(const Duration(seconds: 60 * 2));
  } else {
    throw Exception('BASE_API_URL is not defined in .env file.');
  }
}
