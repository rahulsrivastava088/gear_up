import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:gear_up/view/onBoarding/introScreens/intro_one_page.dart';
import 'package:gear_up/view/onBoarding/introScreens/intro_three_page.dart';
import 'package:gear_up/view/onBoarding/introScreens/intro_two_page.dart';
import 'package:gear_up/view/onBoarding/login/login_page.dart';
import 'package:gear_up/view/onBoarding/login/otp_page.dart';
import 'package:gear_up/view/onBoarding/profileSetUp/select_sports.dart';
import 'package:gear_up/view/onBoarding/profileSetUp/set_age.dart';
import 'package:gear_up/view/onBoarding/profileSetUp/set_gender.dart';
import 'package:gear_up/view/onBoarding/profileSetUp/set_level.dart';
import 'package:gear_up/view/onBoarding/profileSetUp/set_name.dart';
import 'package:gear_up/view/onBoarding/profileSetUp/set_objective.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter returnRouter() {
    GoRouter router = GoRouter(
        initialLocation: '/intro_page_one',
        routes: [
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
