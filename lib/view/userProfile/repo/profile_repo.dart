import 'package:gear_up/utils/urls.dart';
import 'package:gear_up/view/home/model/response/send_connection_response.dart';
import 'package:gear_up/view/userProfile/model/response/accept_request_response.dart';
import 'package:gear_up/view/userProfile/model/response/cancel_request_response.dart';
import 'package:gear_up/view/userProfile/model/response/reject_request_response.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/network/base_api_services.dart';
import '../../../data/network/network_api_services.dart';
import '../../../utils/shared_preferences.dart';
import '../model/response/player_profile_response.dart';

class ProfileRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<PlayerProfile> fetchPlayerProfileData(String playerId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token) ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTk1N2M5MTNiOGU1NjNhYzEzNDRhM2QiLCJpYXQiOjE3MDQyOTU1Njl9.NWThEs1bbrtCTNyzJtB9IS0DuRzJbEsc6nc0QGQ5F4I";

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
    String? token = prefs.getString(SharedPreferenceConstants.token) ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTk1N2M5MTNiOGU1NjNhYzEzNDRhM2QiLCJpYXQiOjE3MDQyOTU1Njl9.NWThEs1bbrtCTNyzJtB9IS0DuRzJbEsc6nc0QGQ5F4I";
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

  Future<SendConnectionRequestResponse> sendConnectionRequest(dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token) ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTk1N2M5MTNiOGU1NjNhYzEzNDRhM2QiLCJpYXQiOjE3MDQyOTU1Njl9.NWThEs1bbrtCTNyzJtB9IS0DuRzJbEsc6nc0QGQ5F4I";
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

  Future<AcceptConnectionRequestResponse> acceptConnectionRequest(dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token) ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTk1N2M5MTNiOGU1NjNhYzEzNDRhM2QiLCJpYXQiOjE3MDQyOTU1Njl9.NWThEs1bbrtCTNyzJtB9IS0DuRzJbEsc6nc0QGQ5F4I";
    try {
      dynamic response = await _apiServices.getPostApiResponseTokenised(
          acceptConnectionRequestUrl, data, token);
      Logger().d(response);
      var res = AcceptConnectionRequestResponse.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<RejectConnectionRequestResponse> rejectConnectionRequest(dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token) ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTk1N2M5MTNiOGU1NjNhYzEzNDRhM2QiLCJpYXQiOjE3MDQyOTU1Njl9.NWThEs1bbrtCTNyzJtB9IS0DuRzJbEsc6nc0QGQ5F4I";
    try {
      dynamic response = await _apiServices.getPostApiResponseTokenised(
          rejectConnectionRequestUrl, data, token);
      Logger().d(response);
      var res = RejectConnectionRequestResponse.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<CancelConnectionRequestResponse> cancelConnectionRequest(dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token) ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTk1N2M5MTNiOGU1NjNhYzEzNDRhM2QiLCJpYXQiOjE3MDQyOTU1Njl9.NWThEs1bbrtCTNyzJtB9IS0DuRzJbEsc6nc0QGQ5F4I";
    try {
      dynamic response = await _apiServices.getPostApiResponseTokenised(
          cancelConnectionRequestUrl, data, token);
      Logger().d(response);
      var res = CancelConnectionRequestResponse.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
