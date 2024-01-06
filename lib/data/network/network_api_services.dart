import 'dart:convert';
import 'dart:io';
import 'package:gear_up/data/app_exceptions.dart';
import 'package:gear_up/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future getPostApiResponse(String url, data) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 7));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
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
}
