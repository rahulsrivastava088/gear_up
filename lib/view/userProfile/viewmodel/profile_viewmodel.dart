import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/view/home/model/request/send_connection_body.dart';
import 'package:gear_up/view/home/model/response/send_connection_response.dart';
import 'package:gear_up/view/userProfile/model/body/accept_request_body.dart';
import 'package:gear_up/view/userProfile/model/body/cancel_request_body.dart';
import 'package:gear_up/view/userProfile/model/body/reject_request_body.dart';
import 'package:gear_up/view/userProfile/model/response/accept_request_response.dart';
import 'package:gear_up/view/userProfile/model/response/cancel_request_response.dart';
import 'package:gear_up/view/userProfile/model/response/player_profile_response.dart';
import 'package:gear_up/view/userProfile/model/response/reject_request_response.dart';
import 'package:gear_up/view/userProfile/repo/profile_repo.dart';
import 'package:stacked/stacked.dart';

import '../../../data/response/api_response.dart';

class ProfileViewModel extends BaseViewModel {
  final _repo = ProfileRepository();

  bool playerProfileApiCalled = false;

  ApiResponse<PlayerProfile> playerProfileReponse = ApiResponse.idle();
  ApiResponse<AcceptConnectionRequestResponse> acceptConnectionRequestResponse = ApiResponse.idle();
  ApiResponse<RejectConnectionRequestResponse> rejectConnectionRequestResponse= ApiResponse.idle();
  ApiResponse<CancelConnectionRequestResponse> cancelConnectionRequestResponse= ApiResponse.idle();
  ApiResponse<SendConnectionRequestResponse> sendConnectionRequestResponse =
      ApiResponse.idle();
  int userConnectionStatus = -1;


  fetchPlayerProfile(String playerId) async {
    playerProfileReponse = ApiResponse.loading();
    _repo
        .fetchPlayerProfileData(playerId)
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                playerProfileReponse = ApiResponse.completed(value),
                playerProfileApiCalled = true
              }
            else
              {
                playerProfileApiCalled = true,
                playerProfileReponse = ApiResponse.error(""),
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            playerProfileReponse = ApiResponse.error(""),
            notifyListeners()
          },
        );
  }

  sendConnectionRequest(String? receiverId) {
    if (receiverId == null) {
      return;
    }

    SendConnectionRequestBody sendConnectionRequestBody =
        SendConnectionRequestBody();

    sendConnectionRequestBody.receiverId = receiverId;

    dynamic data = sendConnectionRequestBody.toJson();

    userConnectionStatus = 0;
    notifyListeners();

    sendConnectionRequestResponse = ApiResponse.loading();
    _repo
        .sendConnectionRequest(data)
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                sendConnectionRequestResponse = ApiResponse.completed(value),
                fetchPlayerProfile(receiverId),
                userConnectionStatus = 1,
              }
            else
              {
                sendConnectionRequestResponse = ApiResponse.error(""),
                userConnectionStatus = 2,
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            sendConnectionRequestResponse = ApiResponse.error(""),
            userConnectionStatus = 2,
            notifyListeners()
          },
        );
  }

  removeConnectionRequest(String playerId) {
    CancelConnectionRequestBody cancelConnectionRequestBody = CancelConnectionRequestBody();
    cancelConnectionRequestBody.connectionUserId = playerId;
    dynamic data = cancelConnectionRequestBody.toJson();

    _repo
        .cancelConnectionRequest(data)
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                cancelConnectionRequestResponse = ApiResponse.completed(value),
                fetchPlayerProfile(playerId),
              }
            else
              {
                cancelConnectionRequestResponse = ApiResponse.error(""),
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            cancelConnectionRequestResponse = ApiResponse.error(""),
            notifyListeners()
          },
        );
  }

  acceptConnectionRequest(String playerId) {
    AcceptConnectionRequestBody acceptConnectionRequestBody = AcceptConnectionRequestBody();
    acceptConnectionRequestBody.senderId = playerId;
    dynamic data = acceptConnectionRequestBody.toJson();

    _repo
        .acceptConnectionRequest(data)
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                acceptConnectionRequestResponse = ApiResponse.completed(value),
                fetchPlayerProfile(playerId),
              }
            else
              {
                acceptConnectionRequestResponse = ApiResponse.error(""),
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            acceptConnectionRequestResponse = ApiResponse.error(""),
            notifyListeners()
          },
        );
  }

  rejectConnectionRequest(String playerId) {
    RejectConnectionRequestBody rejectConnectionRequestBody = RejectConnectionRequestBody();
    rejectConnectionRequestBody.senderId = playerId;
    dynamic data = rejectConnectionRequestBody.toJson();

    _repo
        .rejectConnectionRequest(data)
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                rejectConnectionRequestResponse = ApiResponse.completed(value),
                fetchPlayerProfile(playerId),
              }
            else
              {
                rejectConnectionRequestResponse = ApiResponse.error(""),
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            rejectConnectionRequestResponse = ApiResponse.error(""),
            notifyListeners()
          },
        );
  }

  clearData() {
    playerProfileApiCalled = false;
    playerProfileReponse = ApiResponse.idle();
  }
}
