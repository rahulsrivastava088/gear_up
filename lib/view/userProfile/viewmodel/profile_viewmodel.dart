import 'package:flutter/cupertino.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/view/userProfile/model/player_profile_response.dart';
import 'package:gear_up/view/userProfile/repo/profile_repo.dart';
import 'package:stacked/stacked.dart';
import '../../../data/response/api_response.dart';
import '../../../utils/utilities.dart';

class ProfileViewModel extends BaseViewModel {
  final _repo = ProfileRepository();

  bool playerProfileApiCalled = false;

  ApiResponse<PlayerProfile> playerProfileReponse = ApiResponse.idle();

  fetchPlayerProfile(BuildContext context, String playerId) async {
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
                showSnackBar(context, "There is some issue at our end"),
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            playerProfileReponse = ApiResponse.error(""),
            showSnackBar(
                context, "There is some issue at our end, please retry"),
            notifyListeners()
          },
        );
  }

  clearData() {
    playerProfileApiCalled = false;
    playerProfileReponse = ApiResponse.idle();
  }
}
