import 'package:flutter/cupertino.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../../data/response/api_response.dart';
import '../../../project/routes/app_route_constants.dart';
import '../../../utils/utilities.dart';
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
  String dob = '';
  String userImage = '';
  // 'data:image/png;base64,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';

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
    updateUserBody.objective = Strings.playingObjectiveList[1];
    updateUserBody.playTime = Strings.playingTimeList[1];
    updateUserBody.favoriteSports = [];
    updateUserBody.birthday = 0;
    updateUserBody.bio = '';
    updateUserBody.profession = '';
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
    registerUserResponse = ApiResponse.loading();
    notifyListeners();
    _repo
        .updateUser(data)
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                registerUserResponse = ApiResponse.completed(value),
                GoRouter.of(context).goNamed(
                  RouteConstants.homePageRouteName,
                ),
              }
            else
              {handleApiError(context)},
          },
        )
        .onError(
          (error, stackTrace) => {
            prints(error, stackTrace),
            updateStatus(),
            showSnackBar(context, "Couldn't send the OTP, Please retry"),
          },
        );
  }

  prints(Object? error, StackTrace stackTrace) {
    print(stackTrace.toString());
  }

  updateStatus() {
    registerUserResponse = ApiResponse.error(Strings.apiErrorMessage);
    notifyListeners();
  }

  handleApiError(BuildContext context) {
    registerUserResponse = ApiResponse.error(Strings.apiErrorMessage);
    showSnackBar(context, "We are facing an issue, please retry!");
    notifyListeners();
  }
}
