import 'package:gear_up/utils/urls.dart';
import 'package:gear_up/view/home/model/response/players_list_response.dart';
import 'package:gear_up/view/home/model/response/send_connection_response.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/network/base_api_services.dart';
import '../../../data/network/network_api_services.dart';
import '../../../utils/shared_preferences.dart';

class PlayersRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<PlayersList> fetchPlayers(dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token);
    if (token == null) {
      return Future.error("Invalid token");
    }
    //  ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTk1N2M5MTNiOGU1NjNhYzEzNDRhM2QiLCJpYXQiOjE3MDQyOTU1Njl9.NWThEs1bbrtCTNyzJtB9IS0DuRzJbEsc6nc0QGQ5F4I";
    try {
      dynamic response = await _apiServices.getPostApiResponseTokenised(
          fetchAllPlayersUrl, data, token);
      Logger().d(response);
      var res = PlayersList.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<SendConnectionRequestResponse> sendConnectionRequest(
      dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token);
    if (token == null) {
      return Future.error("Invalid token");
    }
    // ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTk1N2M5MTNiOGU1NjNhYzEzNDRhM2QiLCJpYXQiOjE3MDQyOTU1Njl9.NWThEs1bbrtCTNyzJtB9IS0DuRzJbEsc6nc0QGQ5F4I";
    try {
      dynamic response = await _apiServices.getPostApiResponseTokenised(
          sendConnectionRequestUrl, data, token);
      Logger().d(response);
      var res = SendConnectionRequestResponse.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
