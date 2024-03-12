import 'package:flutter/cupertino.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/view/home/model/request/players_list_request_body.dart';
import 'package:gear_up/view/home/model/request/send_connection_body.dart';
import 'package:gear_up/view/home/model/response/send_connection_response.dart';
import 'package:gear_up/view/home/repo/players_repo.dart';
import 'package:stacked/stacked.dart';

import '../../../data/response/api_response.dart';
import '../model/response/players_list_response.dart';

class PlayersViewModel extends BaseViewModel {
  final _repo = PlayersRepository();

  ApiResponse<PlayersList> playersListResponse = ApiResponse.idle();

  Map<String, int> userConnectionStatus = {};

  fetchPlayers(BuildContext context,
      PlayersListRequestBody playersListRequestBody) async {
    print(playersListRequestBody.toJson());
    dynamic data = playersListRequestBody.toJson();
    playersListResponse = ApiResponse.loading();
    _repo
        .fetchPlayers(data)
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                playersListResponse = ApiResponse.completed(value),
                userConnectionStatus.clear(),
              }
            else
              {
                playersListResponse = ApiResponse.error(""),
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            playersListResponse = ApiResponse.error(""),
            notifyListeners(),
          },
        );
  }

  playersLengthCount() {
    return playersListResponse.data?.players?.length;
  }

  ApiResponse<SendConnectionRequestResponse> sendConnectionRequestResponse =
      ApiResponse.idle();

  sendConnectionRequest(String? receiverId) {
    if (receiverId == null) {
      return;
    }

    SendConnectionRequestBody sendConnectionRequestBody =
        SendConnectionRequestBody();

    sendConnectionRequestBody.receiverId = receiverId;

    dynamic data = sendConnectionRequestBody.toJson();

    userConnectionStatus[receiverId] = 0;
    notifyListeners();

    sendConnectionRequestResponse = ApiResponse.loading();
    _repo
        .sendConnectionRequest(data)
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                sendConnectionRequestResponse = ApiResponse.completed(value),
                userConnectionStatus[receiverId] = 1,
              }
            else
              {
                sendConnectionRequestResponse = ApiResponse.error(""),
                userConnectionStatus[receiverId] = 2,
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            sendConnectionRequestResponse = ApiResponse.error(""),
            userConnectionStatus[receiverId] = 2,
            notifyListeners()
          },
        );
  }
}
