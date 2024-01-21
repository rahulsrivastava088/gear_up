import 'package:gear_up/utils/urls.dart';
import 'package:gear_up/view/home/model/response/players_list_response.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/network/base_api_services.dart';
import '../../../data/network/network_api_services.dart';
import '../../../utils/shared_preferences.dart';

class HomePageRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<PlayersList> fetchAllPlayers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token) ?? "";
    try {
      dynamic response = await _apiServices.getGetApiResponseTokenised(
          fetchAllPlayersUrl, token);
      Logger().d(response);
      var res = PlayersList.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
