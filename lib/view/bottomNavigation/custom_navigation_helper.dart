import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:gear_up/view/bottomNavigation/main.dart';
import 'package:gear_up/view/myGames/gameCard/ui/game_details_main.dart';
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
import 'package:gear_up/view/partners/ui/partners_page_main.dart';
import 'package:gear_up/view/posh/ui/posh_first_page.dart';
import 'package:gear_up/view/posh/ui/posh_information_page.dart';
import 'package:gear_up/view/splashScreen/splash_page.dart';
import 'package:gear_up/view/userProfile/ui/edit_user_profile/main.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/own_user_page_main.dart';
import '../../view/myGames/gameCard/model/response/games_list_response.dart';

final routes = [
  GoRoute(
    path: '/splash_screen',
    pageBuilder: (context, GoRouterState state) {
      return getPage(
        child: const SplashScreen(),
        state: state,
      );
    },
  ),
  GoRoute(
    name: RouteConstants.splashPageRouteName,
    path: '/splash_screen',
    pageBuilder: (context, state) {
      return getPage(state: state, child: const SplashScreen());
    },
  ),
  GoRoute(
    name: RouteConstants.introPage1RouteName,
    path: '/intro_page_one',
    pageBuilder: (context, state) {
      return getPage(state: state, child: const IntroOnePage());
    },
  ),
  GoRoute(
    name: RouteConstants.introPage2RouteName,
    path: '/intro_page_two',
    pageBuilder: (context, state) {
      return getPage(state: state, child: const IntroTwoPage());
    },
  ),
  GoRoute(
    name: RouteConstants.introPage3RouteName,
    path: '/intro_page_three',
    pageBuilder: (context, state) {
      return getPage(state: state, child: const IntroThreePage());
    },
  ),
  GoRoute(
    name: RouteConstants.loginPageRouteName,
    path: '/login_page',
    pageBuilder: (context, state) {
      return getPage(state: state, child: const LoginScreen());
    },
  ),
  GoRoute(
    name: RouteConstants.otpPageRouteName,
    path: '/otp_page',
    pageBuilder: (context, state) {
      return getPage(state: state, child: const OtpScreen());
    },
  ),
  GoRoute(
    name: RouteConstants.selectSportsPageRouteName,
    path: '/select_sports_page',
    pageBuilder: (context, state) {
      return getPage(state: state, child: const SelectSportsScreen());
    },
  ),
  GoRoute(
    name: RouteConstants.selectLevelPageRouteName,
    path: '/select_level_page',
    pageBuilder: (context, state) {
      return getPage(state: state, child: const SetLevelScreen());
    },
  ),
  GoRoute(
    name: RouteConstants.setObjectivePageRouteName,
    path: '/set_objective',
    pageBuilder: (context, state) {
      return getPage(state: state, child: const SetObjectiveScreen());
    },
  ),
  GoRoute(
    name: RouteConstants.setNamePageRouteName,
    path: '/set_name',
    pageBuilder: (context, state) {
      return getPage(state: state, child: const SetNameScreen());
    },
  ),
  GoRoute(
    name: RouteConstants.setAgePageRouteName,
    path: '/set_age',
    pageBuilder: (context, state) {
      return getPage(state: state, child: const SetAgeScreen());
    },
  ),
  GoRoute(
    name: RouteConstants.setGenderPageRouteName,
    path: '/set_gender',
    pageBuilder: (context, state) {
      return getPage(state: state, child: const SetGenderScreen());
    },
  ),
  // GoRoute(
  //   name: RouteConstants.otherUserProfilePageRouteName,
  //   path: '/other_user_profile_page',
  //   pageBuilder: (context, state) {
  //     PlayersWithConnection player = state.extra as PlayersWithConnection;
  //     return getPage(state: state, child: PlayerProfileScreen(player: player));
  //   },
  // ),
  GoRoute(
    name: RouteConstants.userProfilePageRouteName,
    path: '/user_profile_page',
    pageBuilder: (context, state) {
      return getPage(state: state, child: const UserProfileScreen());
    },
  ),
  GoRoute(
    name: RouteConstants.editUserProfilePageRouteName,
    path: '/edit_user_profile_page',
    pageBuilder: (context, state) {
      return getPage(state: state, child: const EditUserProfileScreen());
    },
  ),
  GoRoute(
    name: RouteConstants.homePageRouteName,
    path: '/home_page',
    pageBuilder: (context, state) {
      int? index = state.extra as int?;
      return getPage(
        state: state,
        child: MainScreen(
          initialIndex: index ?? 0,
        ),
      );
    },
  ),
  GoRoute(
    name: RouteConstants.partnersPageRouteName,
    path: '/partners_page',
    pageBuilder: (context, state) {
      return getPage(state: state, child: const PartnersScreen());
    },
  ),
  GoRoute(
    name: RouteConstants.poshPageRouteName,
    path: '/posh_page',
    pageBuilder: (context, state) {
      return getPage(state: state, child: const PoshScreen());
    },
  ),
  GoRoute(
    name: RouteConstants.poshInformationPageRouteName,
    path: '/posh_information_page',
    pageBuilder: (context, state) {
      return getPage(state: state, child: const PoshInformationScreen());
    },
  ),
  GoRoute(
    name: RouteConstants.gameCardPageRouteName,
    path: '/game_card_page',
    pageBuilder: (context, state) {
      Game gameData = state.extra as Game;
      return getPage(state: state, child: GameDetailsPage(game: gameData));
    },
  )
];

Page getPage({
  required Widget child,
  required GoRouterState state,
}) {
  return MaterialPage(
    key: state.pageKey,
    child: SafeArea(
      child: child,
    ),
  );
}
