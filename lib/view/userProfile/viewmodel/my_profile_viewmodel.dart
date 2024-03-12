import 'package:flutter/cupertino.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/view/userProfile/model/response/player_profile_response.dart';
import 'package:gear_up/view/userProfile/repo/profile_repo.dart';
import 'package:stacked/stacked.dart';
import '../../../data/response/api_response.dart';

class MyProfileViewModel extends BaseViewModel {
  final _repo = ProfileRepository();

  ApiResponse<PlayerProfile> myProfileResponse = ApiResponse.idle();

  fetchPlayerProfile(BuildContext context) async {
    myProfileResponse = ApiResponse.loading();
    notifyListeners();
    _repo
        .fetchUserProfileData()
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                myProfileResponse = ApiResponse.completed(value),
              }
            else
              {
                myProfileResponse = ApiResponse.error(""),
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) =>
              {myProfileResponse = ApiResponse.error(""), notifyListeners()},
        );
  }

  clearData() {
    myProfileResponse = ApiResponse.idle();
  }
}
