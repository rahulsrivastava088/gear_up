abstract class BaseApiServices {
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getPostApiResponseTokenised(
      String url, dynamic data, String token);
  Future<dynamic> getGetApiResponseTokenised(String url, String token);
  Future<dynamic> getGetApiResponseTokenisedAndData(
      String url, dynamic data, String token);
  Future<dynamic> getGetApiResponseTokenisedWithPathParam(
      String url, String token, String pathParam);
}
