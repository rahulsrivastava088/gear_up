import 'package:gear_up/utils/urls.dart';
import 'package:gear_up/view/myChats/model/response/access_chat_response.dart';
import 'package:gear_up/view/myChats/model/response/create_game_response.dart'
    as create_game_response;
import 'package:gear_up/view/myChats/model/response/getAllMessages_response.dart';
import 'package:gear_up/view/myChats/model/response/get_venues_response.dart';
import 'package:gear_up/view/myChats/model/response/sendMessage_response.dart';
import 'package:gear_up/view/myChats/model/response/venues_list_response.dart';
import 'package:gear_up/view/myGames/gameCard/model/response/games_list_response.dart'
    as GamesListResponse;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/network/base_api_services.dart';
import '../../../data/network/network_api_services.dart';
import '../../../utils/shared_preferences.dart';
import '../model/response/create_game_response.dart';

class ChatRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<GetAllMessages> fetchAllMessages(String chatId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token) ??
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTk1N2M5MTNiOGU1NjNhYzEzNDRhM2QiLCJpYXQiOjE3MDQyOTU1Njl9.NWThEs1bbrtCTNyzJtB9IS0DuRzJbEsc6nc0QGQ5F4I";

    try {
      dynamic response =
          await _apiServices.getGetApiResponseTokenisedWithPathParam(
              getAllMessagesUrl, token, chatId);
      Logger().d(response);
      var res = GetAllMessages.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<SendMessageResponse> sendMessage(dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token) ??
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTk1N2M5MTNiOGU1NjNhYzEzNDRhM2QiLCJpYXQiOjE3MDQyOTU1Njl9.NWThEs1bbrtCTNyzJtB9IS0DuRzJbEsc6nc0QGQ5F4I";

    try {
      dynamic response = await _apiServices.getPostApiResponseTokenised(
          sendMessageUrl, data, token);
      Logger().d(response);
      var res = SendMessageResponse.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<AccessChatResponse> accessChat(dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token) ??
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTk1N2M5MTNiOGU1NjNhYzEzNDRhM2QiLCJpYXQiOjE3MDQyOTU1Njl9.NWThEs1bbrtCTNyzJtB9IS0DuRzJbEsc6nc0QGQ5F4I";

    try {
      dynamic response = await _apiServices.getPostApiResponseTokenised(
          accessChatUrl, data, token);
      Logger().d(response);
      var res = AccessChatResponse.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<create_game_response.CreateGameResponse> createGame(
      dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token) ??
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTk1N2M5MTNiOGU1NjNhYzEzNDRhM2QiLCJpYXQiOjE3MDQyOTU1Njl9.NWThEs1bbrtCTNyzJtB9IS0DuRzJbEsc6nc0QGQ5F4I";

    try {
      dynamic response = await _apiServices.getPostApiResponseTokenised(
          createGameUrl, data, token);
      Logger().d(response);
      var res = create_game_response.CreateGameResponse.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<VenuesListResponse> fetchVenues() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(fetchAllVenuesUrl);
      Logger().d(response);
      var res = VenuesListResponse.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<CreateGameResponse> updateGame(dynamic data, String gameID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token) ??
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTk1N2M5MTNiOGU1NjNhYzEzNDRhM2QiLCJpYXQiOjE3MDQyOTU1Njl9.NWThEs1bbrtCTNyzJtB9IS0DuRzJbEsc6nc0QGQ5F4I";
    try {
      dynamic response =
          await _apiServices.getPostApiResponseTokenisedWithPathParam(
              updateGameUrl, token, gameID, data);
      Logger().d(response);
      var res = CreateGameResponse.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<GamesListResponse.Game> updateGameDetail(
      dynamic data, String gameID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token) ??
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTk1N2M5MTNiOGU1NjNhYzEzNDRhM2QiLCJpYXQiOjE3MDQyOTU1Njl9.NWThEs1bbrtCTNyzJtB9IS0DuRzJbEsc6nc0QGQ5F4I";
    try {
      dynamic response =
          await _apiServices.getPostApiResponseTokenisedWithPathParam(
              updateGameUrl, token, gameID, data);
      Logger().d(response);
      var res = GamesListResponse.Game.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetVenuesResponse> getVenues() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(getVenuesUrl);
      Logger().d(response);
      var res = GetVenuesResponse.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
