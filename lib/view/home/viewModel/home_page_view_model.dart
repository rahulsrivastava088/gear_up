import 'package:flutter/cupertino.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/view/home/model/request/players_list_request_body.dart';
import 'package:gear_up/view/home/repo/players_repo.dart';
import 'package:stacked/stacked.dart';
import '../../../data/response/api_response.dart';
import '../model/response/players_list_response.dart';

class PlayersViewModel extends BaseViewModel {
  final _repo = PlayersRepository();

  ApiResponse<PlayersList> playersListResponse = ApiResponse.idle();

  fetchPlayers(BuildContext context,
      PlayersListRequestBody playersListRequestBody) async {
    dynamic data = playersListRequestBody.toJson();
    playersListResponse = ApiResponse.loading();
    _repo
        .fetchPlayers(data)
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                playersListResponse = ApiResponse.completed(value),
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
}
