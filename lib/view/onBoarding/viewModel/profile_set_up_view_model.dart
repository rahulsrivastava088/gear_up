import 'package:flutter/cupertino.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/utils/shared_preferences.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../../data/response/api_response.dart';
import '../../../utils/utilities.dart';
import '../../../project/routes/custom_navigator.dart';
import '../model/request/update_user_request_body.dart' as user_req;
import '../model/response/update_user_response_body.dart' as user_res;
import '../repo/on_boarding_repository.dart';

class ProfileSetUpViewModel extends BaseViewModel {
  final _repo = OnBoardingRepository();
  ApiResponse<user_res.UpdateUser> registerUserResponse = ApiResponse.idle();

  List<int> selectedSports = [];
  List<int> selectedLevel = [];
  int selectedGender = -1;
  int selectedObjective = -1;
  int selectedPlayTime = -1;
  String firstName = '';
  String lastName = '';
  int dob = 0;
  String userImage = '';
  String? lat;
  String? long;

  bool isApiError = false;
  user_req.UpdateUserBody updateUserBody = user_req.UpdateUserBody();

  void markSportAsSelected(int index) {
    if (!selectedSports.contains(index)) {
      selectedSports.add(index);
    }
    updatedSelectedLevelList();
  }

  void markSportAsUnselected(int index) {
    selectedSports.remove(index);
    updatedSelectedLevelList();
  }

  void updatedSelectedLevelList() {
    selectedLevel.clear();
    for (final _ in selectedSports) {
      selectedLevel.add(-1);
    }
  }

  bool isLevelListValid() {
    for (final index in selectedLevel) {
      if (index == -1) {
        return false;
      }
    }
    return true;
  }

  bool isValidDate(String input) {
    try {
      List<String> parts = input.split('/');
      if (parts.length != 3) {
        return false;
      }
      String formattedDate = "${parts[2]}-${parts[1]}-${parts[0]}";
      DateFormat format = DateFormat("yyyy-MM-dd");
      format.parseStrict(formattedDate);
      return true;
    } catch (e) {
      return false;
    }
  }

  updateUser(BuildContext context) async {
    updateUserBody.firstName = firstName;
    updateUserBody.lastName = lastName;
    updateUserBody.gender = Strings.genderList[selectedGender];
    updateUserBody.objective = Strings.playingObjectiveList[selectedObjective];
    updateUserBody.playTime = Strings.playingTimeList[selectedPlayTime];
    updateUserBody.favoriteSports = [];
    updateUserBody.birthday = dob;
    updateUserBody.bio = '';
    updateUserBody.profession = '';
    updateUserBody.currentAddress = user_req.Address(lat: lat, lng: long);
    for (int i = 0; i < selectedSports.length; i++) {
      updateUserBody.favoriteSports!.add(
        user_req.FavoriteSport(
          sport: getSportID(selectedSports[i]),
          level: Strings.levelsList[selectedLevel[i]],
        ),
      );
    }
    updateUserBody.img = userImage;
    dynamic data = updateUserBody.toJson();
    print("request: $data");
    registerUserResponse = ApiResponse.loading();
    // notifyListeners();
    _repo
        .updateUser(data)
        .then(
          (value) async => {
            if (value.status.toString().isSuccess())
              {
                registerUserResponse = ApiResponse.completed(value),
                await updateSharedPrefData(value),
                CustomNavigationHelper.router
                    .go(CustomNavigationHelper.homePath),
              }
            else
              {
                registerUserResponse =
                    ApiResponse.error(Strings.apiErrorMessage),
                showSnackBar(context, "We are facing an issue, please retry!"),
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            registerUserResponse = ApiResponse.error(Strings.apiErrorMessage),
            showSnackBar(context, "We are facing an issue, please retry!"),
            notifyListeners(),
          },
        );
  }

  updateSharedPrefData(user_res.UpdateUser value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharedPreferenceConstants.isNewUser, false);
  }

  updateLocation() {
    CustomNavigationHelper.router.go(CustomNavigationHelper.homePath);
  }
}
