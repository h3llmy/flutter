import 'dart:convert';

import 'package:http/http.dart';

dynamic futureBuilderHanler(Object? error) {
  dynamic errorObject = {};
  if (error is ClientException) {
    errorObject['message'] = "Something went worng please try again later";
  } else {
    errorObject = jsonDecode(error.toString());
  }
  return errorObject;
}
