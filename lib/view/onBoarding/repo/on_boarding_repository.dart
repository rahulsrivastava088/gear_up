import 'package:gear_up/utils/urls.dart';
import 'package:gear_up/view/onBoarding/model/response/register_user_response.dart';
import 'package:gear_up/view/onBoarding/model/response/update_user_response_body.dart';
import 'package:gear_up/view/onBoarding/model/response/verify_user_response.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/network/base_api_services.dart';
import '../../../data/network/network_api_services.dart';
import '../../../utils/shared_preferences.dart';

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
  } //

  Future<UpdateUser> updateUser(dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token) ?? "";
    try {
      dynamic response = await _apiServices.getPostApiResponseTokenised(
          updateUserUrl, data, token);
      print("response: ${response}");
      var res = UpdateUser.fromJson(response);
      print("json response: ${res}");
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
