import 'dart:async';
import 'package:country_state_city/utils/country_utils.dart';
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
import '../../../utils/shared_preferences.dart';
import '../../../project/routes/custom_navigator.dart';

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

  String selectedCountryCode = '91';
  String selectedCountryName = 'India';

  int x = 0;
  updateIntroScreen(bool increase) {
    // while (currentScreenNumber < 2) {
    // Future.delayed(
    //   const Duration(seconds: 2),
    //   () {
    if (increase) {
      increaseScreenNumber();
    } else {
      decreaseScreenNumber();
    }
    // },
    // );
    // }
  }

  increaseScreenNumber() {
    if (currentScreenNumber < 2) {
      currentScreenNumber++;
      notifyListeners();
    }
  }

  decreaseScreenNumber() {
    if (currentScreenNumber > 0) {
      currentScreenNumber--;
      notifyListeners();
    }
  }

  setRegisterUserLoading(bool value) {
    _registerUserLoading = value;
    notifyListeners();
  }

  setVerifyUserLoading(bool value) {
    _verifyUserLoading = value;
    notifyListeners();
  }

  int currentScreenNumber = 0;

  final screenText = [
    "Find a partner to play\nwith, suitable to your\npreference and need",
    "Participate in\ntournaments\nhappening near you",
    "Join teams &\ncommunities with like\nminded people."
  ];

  getScreenText() {
    return screenText[currentScreenNumber];
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
          (value) async => {
            if (value.status.toString().isSuccess())
              {
                showSnackBar(context, "OTP Sent"),
                registerUserResponse = ApiResponse.completed(value),
                _remainingSeconds = 10,
                startCountdown(),
                navigateToOTPScreen(context),
                await Future.delayed(const Duration(milliseconds: 500)),
                setRegisterUserLoading(false),
              }
            else
              {
                registerUserResponse =
                    ApiResponse.error(Strings.otpNotSentMessage),
                showSnackBar(context, "Couldn't send OTP, Please retry"),
                setRegisterUserLoading(false),
              },
          },
        )
        .onError(
          (error, stackTrace) => {
            setRegisterUserLoading(false),
            showSnackBar(context, "Couldn't send the OTP, Please retry"),
          },
        );
  }

  resendOtp(BuildContext context) async {
    if (registerUserBody.mobileNumber == null ||
        registerUserBody.country == null) {
      context.pop();
    }
    isResendVisible = false;
    // setVerifyUserLoading(false);

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
            (value) async => {
              if (value.status.toString().isSuccess())
                {
                  verifyUserResponse = ApiResponse.completed(value),
                  saveUserCredsInSharedPref(),
                  if (verifyUserResponse.data?.user?.newUser == true)
                    {navigateToSetUpProfileScreen(context)}
                  else
                    {navigateToHomeScreen(context)},
                  await Future.delayed(const Duration(milliseconds: 500))
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
    CustomNavigationHelper.router.push(CustomNavigationHelper.otpPath);
  }

  navigateToHomeScreen(BuildContext context) {
    CustomNavigationHelper.router.push(CustomNavigationHelper.homePath);
  }

  navigateToSetUpProfileScreen(BuildContext context) {
    CustomNavigationHelper.router.push(CustomNavigationHelper.selectSportsPath);
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
          _remainingSeconds = 10;
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

  getColor(int position) {
    if (position == currentScreenNumber) {
      return Colors.white;
    } else {
      return const Color(0xFF333333);
    }
  }

  double getSize(int position) {
    if (position == currentScreenNumber) {
      return 10;
    } else {
      return 8;
    }
  }

  getCountries() {
    var list = getAllCountries();
  }
}
