import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gear_up/data/response/api_response.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/utils/utilities.dart';
import 'package:gear_up/view/onBoarding/model/request/register_user_request.dart';
import 'package:gear_up/view/onBoarding/model/request/verify_user_request.dart';
import 'package:gear_up/view/onBoarding/model/response/register_user_response.dart';
import 'package:gear_up/view/onBoarding/model/response/verify_user_response.dart';
import 'package:gear_up/view/onBoarding/repo/on_boarding_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../../project/routes/app_route_constants.dart';
import '../../../utils/shared_preferences.dart';

class OnBoardingViewModel extends BaseViewModel {
  final _repo = OnBoardingRepository();

  ApiResponse<RegisterUser> registerUserResponse = ApiResponse.loading();
  ApiResponse<VerifyUser> verifyUserResponse = ApiResponse.loading();

  RegisterUserBody registerUserBody = RegisterUserBody();
  VerifyUserBody verifyUserBody = VerifyUserBody();

  bool _registerUserLoading = false;
  bool get registerUserLoading => _registerUserLoading;

  bool _verifyUserLoading = false;
  bool get verifyUserLoading => _verifyUserLoading;

  int _remainingSeconds = 10;
  int get remainingSeconds => _remainingSeconds;
  bool isResendVisible = false;

  setRegisterUserLoading(bool value) {
    _registerUserLoading = value;
    notifyListeners();
  }

  setVerifyUserLoading(bool value) {
    _verifyUserLoading = value;
    notifyListeners();
  }

  registerUser(
      String country, String mobileNumber, BuildContext context) async {
    registerUserBody.country = country;
    registerUserBody.mobileNumber = mobileNumber;
    dynamic data = registerUserBody.toJson();
    isResendVisible = false;
    setRegisterUserLoading(true);

    _repo
        .registerUser(data)
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                showSnackBar(context, "OTP Sent"),
                registerUserResponse = ApiResponse.completed(value),
                _remainingSeconds = 10,
                startCountdown(),
                navigateToOTPScreen(context)
              }
            else
              {
                registerUserResponse =
                    ApiResponse.error(Strings.otpNotSentMessage),
                showSnackBar(context, "Couldn't send OTP, Please retry"),
              },
            setRegisterUserLoading(false),
          },
        )
        .onError((error, stackTrace) => {
              setRegisterUserLoading(false),
              showSnackBar(context, "Couldn't send the OTP, Please retry")
            });
  }

  resendOtp(BuildContext context) async {
    if (registerUserBody.mobileNumber == null ||
        registerUserBody.country == null) {
      context.pop();
    }
    isResendVisible = false;
    setVerifyUserLoading(false);

    dynamic data = registerUserBody.toJson();
    _repo
        .registerUser(data)
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                registerUserResponse = ApiResponse.completed(value),
                showSnackBar(context, "OTP Resent"),
                _remainingSeconds = 10,
                notifyListeners(),
                startCountdown(),
              }
            else
              {
                registerUserResponse = ApiResponse.error("Couldn't send OTP"),
                showSnackBar(context, "Couldn't send OTP, Please retry")
              },
          },
        )
        .onError((error, stackTrace) =>
            {showSnackBar(context, "Couldn't send OTP, Please retry")});
  }

  verifyUser(BuildContext context, String otp) async {
    if (registerUserResponse.data == null) {
      showSnackBar(context, "Get OTP again");
      notifyListeners();
      context.pop();
    } else {
      verifyUserBody.otpEntered = otp;
      verifyUserBody.otpId = registerUserResponse.data?.otpId;
      dynamic data = verifyUserBody.toJson();
      setVerifyUserLoading(true);
      _repo
          .verifyUser(data)
          .then(
            (value) => {
              if (value.status.toString().isSuccess())
                {
                  verifyUserResponse = ApiResponse.completed(value),
                  saveUserCredsInSharedPref(),
                  if (verifyUserResponse.data?.user?.newUser == true)
                    {navigateToSetUpProfileScreen(context)}
                  else
                    {navigateToHomeScreen(context)}
                }
              else
                {
                  verifyUserResponse = ApiResponse.error(
                      "Incorrect OTP, Please enter correct OTP"),
                  showSnackBar(
                      context, "Incorrect OTP, Please enter correct OTP"),
                },
              setVerifyUserLoading(false)
            },
          )
          .onError((error, stackTrace) => {
                setVerifyUserLoading(false),
                showSnackBar(context, "Couldn't verify OTP, Please try again")
              });
    }
  }

  navigateToOTPScreen(BuildContext context) {
    GoRouter.of(context).pushNamed(RouteConstants.otpPageRouteName);
  }

  navigateToHomeScreen(BuildContext context) {
    GoRouter.of(context).pushNamed(RouteConstants.homePageRouteName);
  }

  navigateToSetUpProfileScreen(BuildContext context) {
    GoRouter.of(context).pushNamed(RouteConstants.selectSportsPageRouteName);
  }

  resetOTPPageData() {
    verifyUserBody = VerifyUserBody();
    verifyUserResponse = ApiResponse.loading();
    setVerifyUserLoading(false);
    stopCountDown();
  }

  resetLoginPageData() {
    registerUserBody = RegisterUserBody();
    registerUserResponse = ApiResponse.loading();
    setRegisterUserLoading(false);
  }

  void startCountdown() {
    if (isResendVisible) {
      notifyListeners();
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        _remainingSeconds--;
        if (_remainingSeconds > 0) {
          notifyListeners();
          startCountdown();
        } else {
          isResendVisible = true;
          notifyListeners();
        }
      });
    }
  }

  void stopCountDown() {
    _remainingSeconds = 0;
    isResendVisible = true;
  }

  void saveUserCredsInSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (verifyUserResponse.data?.token != null) {
      await prefs.setBool(SharedPreferenceConstants.isNewUser,
          verifyUserResponse.data?.user?.newUser == true ? true : false);
      await prefs.setString(SharedPreferenceConstants.token,
          verifyUserResponse.data?.token ?? '');
    }
  }
}
