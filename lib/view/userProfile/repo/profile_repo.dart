import 'package:gear_up/utils/urls.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/network/base_api_services.dart';
import '../../../data/network/network_api_services.dart';
import '../../../utils/shared_preferences.dart';
import '../model/player_profile_response.dart';

class ProfileRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<PlayerProfile> fetchPlayerProfileData(String playerId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token) ?? "";

    try {
      dynamic response =
          await _apiServices.getGetApiResponseTokenisedWithPathParam(
              fetchPlayerProfileDataUrl, token, playerId);
      Logger().d(response);
      var res = PlayerProfile.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<PlayerProfile> fetchUserProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token) ?? "";
    try {
      dynamic response = await _apiServices.getGetApiResponseTokenised(
          fetchUserProfileDataUrl, token);
      Logger().d(response);
      var res = PlayerProfile.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
