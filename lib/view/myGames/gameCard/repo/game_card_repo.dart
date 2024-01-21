import 'package:gear_up/utils/urls.dart';
import 'package:gear_up/view/myGames/gameCard/model/response/games_list_response.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/network/base_api_services.dart';
import '../../../../data/network/network_api_services.dart';
import '../../../../utils/shared_preferences.dart';

class GamesRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<GamesList> fetchMyGames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTk4MjI2ZmU3N2ZiNzk3ZTVlYTQ1OTAiLCJpYXQiOjE3MDQ0NjkxMDN9.m6C9_GccBFxqLu9bxEgDaFXcipuXtdQhJJdLIJQwoH0';
    // String? token = prefs.getString(SharedPreferenceConstants.token) ?? "";
    try {
      dynamic response =
          await _apiServices.getGetApiResponseTokenised(fetchMyGamesUrl, token);
      Logger().d(response);
      var res = GamesList.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
