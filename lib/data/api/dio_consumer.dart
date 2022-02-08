import 'package:dio/dio.dart';
import 'package:sample_app/data/api/custom_exception.dart';
import 'package:sample_app/data/api/dio_response.dart';

import 'api_consumer.dart';
import 'dart:io';
import 'dart:async';

class DioConsumer extends ApiConsumer {
  @override
  Future get(String url, {Map<String, String>? headers}) async {
    try {
      final response = await Dio().get(url,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
            headers: headers,
          ));
      // ignore: avoid_print
      print(response);
      var responseJson = handleDioResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  @override
  Future<dynamic> post(String url, {body, Map<String, String>? headers}) async {
    try {
      final response = await Dio().post(url,
          data: body,
          options: Options(
            contentType: 'application/json',
            responseType: ResponseType.plain,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
            headers: headers,
          ));
      // ignore: avoid_print
      print(response);
      var responseJson = handleDioResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }
}
