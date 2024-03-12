import 'dart:convert';
import 'dart:io';
import 'package:gear_up/data/app_exceptions.dart';
import 'package:gear_up/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 7));
      Logger().d("resp: ${response.body}");

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponseTokenised(
      String url, dynamic data, String token) async {
    dynamic responseJson;
    final msg = jsonEncode(data);
    try {
      final response = await http
          .post(
            Uri.parse(url),
            body: msg,
            headers: {
              'Content-type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            encoding: Encoding.getByName("utf-8"),
          )
          .timeout(const Duration(seconds: 7));
      Logger().d("resp: ${response.body}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getGetApiResponseTokenised(String url, String token) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 7));
      Logger().d("resp: ${response.body}");

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
        },
      ).timeout(const Duration(seconds: 7));
      Logger().d("resp: ${response.body}");

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getGetApiResponseTokenisedWithPathParam(
      String url, String token, String pathParam) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.parse('$url/$pathParam'),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 7));
      Logger().d("resp: ${response.body}");

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponseTokenisedWithPathParam(
      String url, String token, String pathParam, dynamic data) async {
    dynamic responseJson;
    final msg = jsonEncode(data);
    try {
      final response = await http
          .post(
            Uri.parse('$url$pathParam'),
            body: msg,
            headers: {
              'Content-type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            encoding: Encoding.getByName("utf-8"),
          )
          .timeout(const Duration(seconds: 7));
      Logger().d("resp: ${response.body}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(
            'Bad Request Exception, status: ${response.statusCode}');
      case 401:
        throw UnauthorizedException(
            'Unauthorized Exception, status: ${response.statusCode}');
      default:
        throw FetchDataException(
            'Error occured with status code: ${response.statusCode}');
    }
  }

  @override
  Future getGetApiResponseTokenisedAndData(
      String url, data, String token) async {
    dynamic responseJson;
    final msg = jsonEncode(data);
    try {
      final response = await http
          .post(
            Uri.parse(url),
            body: msg,
            headers: {
              'Content-type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            encoding: Encoding.getByName("utf-8"),
          )
          .timeout(const Duration(seconds: 7));
      Logger().d("resp: ${response.body}");

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponseTokenisedWithFile(
      String url, dynamic data, String token, File file) async {
    dynamic responseJson;
    // final msg = jsonEncode(data);
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );

      String jsonString = json.encode(data);
      request.fields['jsonBody'] = jsonString;
      request.headers['Content-type'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';
      // Attach the file to the request
      var fileStream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile = http.MultipartFile(
        'file',
        fileStream,
        length,
        filename: file.path.split("/").last,
        // Encoding.utf8,
      );

      request.files.add(multipartFile);
      final response = await request
          .send()
          // .post(
          // Uri.parse(url),
          // body: msg,
          // headers: {
          //   'Content-type': 'application/json',
          //   'Authorization': 'Bearer $token',
          // },
          // encoding: Encoding.getByName("utf-8"),
          // )
          .timeout(const Duration(seconds: 7));

      final responseBody = response.stream.bytesToString();
      Logger().d("resp: $responseBody");
      // responseJson = returnResponse(responseBody);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }
}
