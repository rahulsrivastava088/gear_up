import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:gear_up/view/bottomNavigation/main.dart';
import 'package:gear_up/view/onBoarding/loginUi/introScreens/intro_one_page.dart';
import 'package:gear_up/view/onBoarding/loginUi/introScreens/intro_three_page.dart';
import 'package:gear_up/view/onBoarding/loginUi/introScreens/intro_two_page.dart';
import 'package:gear_up/view/onBoarding/loginUi/login/login_page.dart';
import 'package:gear_up/view/onBoarding/loginUi/login/otp_page.dart';
import 'package:gear_up/view/onBoarding/profileSetUpUi/select_sports.dart';
import 'package:gear_up/view/onBoarding/profileSetUpUi/set_age.dart';
import 'package:gear_up/view/onBoarding/profileSetUpUi/set_gender.dart';
import 'package:gear_up/view/onBoarding/profileSetUpUi/set_level.dart';
import 'package:gear_up/view/onBoarding/profileSetUpUi/set_name.dart';
import 'package:gear_up/view/onBoarding/profileSetUpUi/set_objective.dart';
import 'package:gear_up/view/partners/main.dart';
import 'package:gear_up/view/splashScreen/splash_page.dart';
import 'package:gear_up/view/userProfile/edit/main.dart';
import 'package:gear_up/view/userProfile/userDetails/main.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter returnRouter() {
    GoRouter router = GoRouter(
        initialLocation: '/home_page',
        routes: [
          GoRoute(
            name: RouteConstants.splashPageRouteName,
            path: '/splash_screen',
            pageBuilder: (context, state) {
              return const MaterialPage(child: SafeArea(child: SplashScreen()));
            },
          ),
          GoRoute(
            name: RouteConstants.introPage1RouteName,
            path: '/intro_page_one',
            pageBuilder: (context, state) {
              return const MaterialPage(child: SafeArea(child: IntroOnePage()));
            },
          ),
          GoRoute(
            name: RouteConstants.introPage2RouteName,
            path: '/intro_page_two',
            pageBuilder: (context, state) {
              return const MaterialPage(child: SafeArea(child: IntroTwoPage()));
            },
          ),
          GoRoute(
            name: RouteConstants.introPage3RouteName,
            path: '/intro_page_three',
            pageBuilder: (context, state) {
              return const MaterialPage(
                  child: SafeArea(child: IntroThreePage()));
            },
          ),
          GoRoute(
            name: RouteConstants.loginPageRouteName,
            path: '/login_page',
            pageBuilder: (context, state) {
              return const MaterialPage(child: LoginScreen());
            },
          ),
          GoRoute(
            name: RouteConstants.otpPageRouteName,
            path: '/otp_page',
            pageBuilder: (context, state) {
              return const MaterialPage(child: OtpScreen());
            },
          ),
          GoRoute(
            name: RouteConstants.selectSportsPageRouteName,
            path: '/select_sports_page',
            pageBuilder: (context, state) {
              return const MaterialPage(
                  child: SafeArea(child: SelectSportsScreen()));
            },
          ),
          GoRoute(
            name: RouteConstants.selectLevelPageRouteName,
            path: '/select_level_page',
            pageBuilder: (context, state) {
              return const MaterialPage(
                  child: SafeArea(child: SetLevelScreen()));
            },
          ),
          GoRoute(
            name: RouteConstants.setObjectivePageRouteName,
            path: '/set_objective',
            pageBuilder: (context, state) {
              return const MaterialPage(
                  child: SafeArea(child: SetObjectiveScreen()));
            },
          ),
          GoRoute(
            name: RouteConstants.setNamePageRouteName,
            path: '/set_name',
            pageBuilder: (context, state) {
              return const MaterialPage(
                  child: SafeArea(child: SetNameScreen()));
            },
          ),
          GoRoute(
            name: RouteConstants.setAgePageRouteName,
            path: '/set_age',
            pageBuilder: (context, state) {
              return const MaterialPage(child: SafeArea(child: SetAgeScreen()));
            },
          ),
          GoRoute(
            name: RouteConstants.setGenderPageRouteName,
            path: '/set_gender',
            pageBuilder: (context, state) {
              return const MaterialPage(
                  child: SafeArea(child: SetGenderScreen()));
            },
          ),
          GoRoute(
            name: RouteConstants.userProfilePageRouteName,
            path: '/user_profile_page',
            pageBuilder: (context, state) {
              return const MaterialPage(
                  child: SafeArea(child: UserProfileScreen()));
            },
          ),
          GoRoute(
            name: RouteConstants.editUserProfilePageRouteName,
            path: '/edit_user_profile_page',
            pageBuilder: (context, state) {
              return const MaterialPage(
                  child: SafeArea(child: EditUserProfileScreen()));
            },
          ),
          GoRoute(
            name: RouteConstants.homePageRouteName,
            path: '/home_page',
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: SafeArea(
                  child: MainScreen(
                    initialIndex: 0,
                  ),
                ),
              );
            },
          ),
          GoRoute(
            name: RouteConstants.partnersPageRouteName,
            path: '/partners_page',
            pageBuilder: (context, state) {
              return const MaterialPage(
                  child: SafeArea(child: PartnersScreen()));
            },
          )
        ],
        errorPageBuilder: (context, state) {
          return const MaterialPage(
              child: Scaffold(
                  body: Align(
                      alignment: Alignment.center,
                      child: Text("Some error, will look into it soon"))));
        },
        redirect: (context, state) {
          return;
        });
    return router;
  }
}
