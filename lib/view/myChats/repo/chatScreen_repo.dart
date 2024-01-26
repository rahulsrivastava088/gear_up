import 'package:gear_up/utils/urls.dart';
import 'package:gear_up/view/myChats/model/getAllMessages_response.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/network/base_api_services.dart';
import '../../../data/network/network_api_services.dart';
import '../../../utils/shared_preferences.dart';

class ChatRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<GetAllMessages> fetchAllMessages(String chatId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token) ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTk1N2M5MTNiOGU1NjNhYzEzNDRhM2QiLCJpYXQiOjE3MDQyOTU1Njl9.NWThEs1bbrtCTNyzJtB9IS0DuRzJbEsc6nc0QGQ5F4I";

    try {
      dynamic response =
          await _apiServices.getGetApiResponseTokenisedWithPathParam(
              getAllMessages, token, chatId);
      Logger().d(response);
      var res = GetAllMessages.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }

}
