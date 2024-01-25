import 'package:flutter/cupertino.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/view/userProfile/model/player_profile_response.dart';
import 'package:gear_up/view/userProfile/repo/profile_repo.dart';
import 'package:stacked/stacked.dart';
import '../../../data/response/api_response.dart';
import '../../../utils/utilities.dart';

class MyProfileViewModel extends BaseViewModel {
  final _repo = ProfileRepository();

  bool myProfileApiCalled = false;

  ApiResponse<PlayerProfile> myProfileReponse = ApiResponse.idle();

  fetchPlayerProfile(BuildContext context) async {
    myProfileReponse = ApiResponse.loading();
    _repo
        .fetchUserProfileData()
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                myProfileReponse = ApiResponse.completed(value),
                myProfileApiCalled = true
              }
            else
              {
                myProfileApiCalled = true,
                myProfileReponse = ApiResponse.error(""),
                showSnackBar(context, "There is some issue at our end"),
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            myProfileReponse = ApiResponse.error(""),
            showSnackBar(
                context, "There is some issue at our end, please retry"),
            notifyListeners()
          },
        );
  }

  clearData() {
    myProfileApiCalled = false;
    myProfileReponse = ApiResponse.idle();
  }
}
