abstract class BaseApiServices {
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getPostApiResponseTokenised(
      String url, dynamic data, String token);
  Future<dynamic> getGetApiResponseTokenised(String url, String token);
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getGetApiResponseTokenisedAndData(
      String url, dynamic data, String token);
  Future<dynamic> getGetApiResponseTokenisedWithPathParam(
      String url, String token, String pathParam);
  Future<dynamic> getPostApiResponseTokenisedWithPathParam(
      String url, String token, String pathParam, dynamic data);
  Future<dynamic> getGetApiResponse(String url);
}
