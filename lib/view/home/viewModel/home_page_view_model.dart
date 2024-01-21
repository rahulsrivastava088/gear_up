import 'package:flutter/cupertino.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/view/home/model/response/players_list_response.dart';
import 'package:gear_up/view/home/repo/home_page_repo.dart';
import 'package:stacked/stacked.dart';

import '../../../data/response/api_response.dart';
import '../../../utils/utilities.dart';

class HomePageViewModel extends BaseViewModel {
  final _repo = HomePageRepository();
  bool apiCalled = false;

  ApiResponse<PlayersList> playersListResponse = ApiResponse.idle();

  fetchAllPlayers(BuildContext context) async {
    playersListResponse = ApiResponse.loading();
    _repo
        .fetchAllPlayers()
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                playersListResponse = ApiResponse.completed(value),
                apiCalled = true
              }
            else
              {
                playersListResponse = ApiResponse.error(""),
                showSnackBar(context, "There is some issue at our end"),
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            playersListResponse = ApiResponse.error(""),
            showSnackBar(context, "There is some issue at our end, please ret"),
            notifyListeners()
          },
        );
  }

  playersLengthCount() {
    return playersListResponse.data?.playersWithConnections?.length;
  }
}
