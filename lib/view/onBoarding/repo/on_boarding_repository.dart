import 'package:gear_up/utils/urls.dart';
import 'package:gear_up/view/onBoarding/model/response/register_user_response.dart';
import 'package:gear_up/view/onBoarding/model/response/verify_user_response.dart';
import '../../../data/network/base_api_services.dart';
import '../../../data/network/network_api_services.dart';

class OnBoardingRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<RegisterUser> registerUser(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(registerUserUrl, data);
      return response = RegisterUser.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<VerifyUser> verifyUser(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(verifyUserUrl, data);
      return response = VerifyUser.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<VerifyUser> updateUser(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(verifyUserUrl, data);
      return response = VerifyUser.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
