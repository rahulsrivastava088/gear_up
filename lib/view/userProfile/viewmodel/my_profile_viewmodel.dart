import 'package:flutter/cupertino.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/view/userProfile/model/response/player_profile_response.dart';
import 'package:gear_up/view/userProfile/repo/profile_repo.dart';
import 'package:stacked/stacked.dart';
import '../../../data/response/api_response.dart';

class MyProfileViewModel extends BaseViewModel {
  final _repo = ProfileRepository();

  ApiResponse<PlayerProfile> myProfileReponse = ApiResponse.idle();

  fetchPlayerProfile(BuildContext context) async {
    myProfileReponse = ApiResponse.loading();
    notifyListeners();
    _repo
        .fetchUserProfileData()
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                myProfileReponse = ApiResponse.completed(value),
              }
            else
              {
                myProfileReponse = ApiResponse.error(""),
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) =>
              {myProfileReponse = ApiResponse.error(""), notifyListeners()},
        );
  }

  clearData() {
    myProfileReponse = ApiResponse.idle();
  }
}
