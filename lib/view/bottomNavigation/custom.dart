import 'package:flutter/material.dart';
import 'package:gear_up/view/bottomNavigation/page.dart';
import 'package:gear_up/view/home/ui/home_page_main.dart';
import 'package:gear_up/view/myChats/ui/chat_page_main.dart';
import 'package:gear_up/view/myGames/gameCard/ui/game_details_main.dart';
import 'package:gear_up/view/myGames/my_games_page_main.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/otp_status_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/introScreens/intro_one_page.dart';
import 'package:gear_up/view/onBoarding/loginUi/introScreens/intro_three_page.dart';
import 'package:gear_up/view/onBoarding/loginUi/introScreens/intro_two_page.dart';
import 'package:gear_up/view/onBoarding/loginUi/login/login_page.dart';
import 'package:gear_up/view/onBoarding/loginUi/login/otp_page.dart';
import 'package:gear_up/view/onBoarding/profileSetUpUi/select_sports.dart';
import 'package:gear_up/view/onBoarding/profileSetUpUi/set_age.dart';
import 'package:gear_up/view/onBoarding/profileSetUpUi/set_gender.dart';
import 'package:gear_up/view/onBoarding/profileSetUpUi/set_name.dart';
import 'package:gear_up/view/onBoarding/profileSetUpUi/set_objective.dart';
import 'package:gear_up/view/partners/ui/partners_page_main.dart';
import 'package:gear_up/view/posh/ui/posh_assessment_page.dart';
import 'package:gear_up/view/posh/ui/posh_first_page.dart';
import 'package:gear_up/view/posh/ui/posh_results_page.dart';
import 'package:gear_up/view/splashScreen/splash_page.dart';
import 'package:gear_up/view/userProfile/ui/edit_user_profile/main.dart';
import 'package:gear_up/view/userProfile/ui/player_profile/player_profile_main_page.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/own_user_page_main.dart';
import 'package:go_router/go_router.dart';
import '../myGames/gameCard/model/response/games_list_response.dart';
import '../onBoarding/profileSetUpUi/set_level.dart';
import '../posh/ui/posh_information_page.dart';

class CustomNavigationHelper {
  static final CustomNavigationHelper _instance =
      CustomNavigationHelper._internal();

  static CustomNavigationHelper get instance => _instance;

  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> homeTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> partnersTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> myGamesTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> myProfileTabNavigatorKey =
      GlobalKey<NavigatorState>();

  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  static const String playerProfilePath = '/playerProfile';
  static const String homePath = '/home';
  static const String partnersPath = '/partners';
  static const String myGamesPath = '/my_games';
  static const String myProfilePath = '/my_profile';
  static const String editProfilePath = '/edit_profile';
  static const String splashPath = '/splash';
  static const String poshPath = '/posh';
  static const String poshInformationPath = '/posh_information';
  static const String poshAssessmentPath = '/posh_assessment';
  static const String poshResultsPath = '/posh_results';
  static const String myChatPath = '/chat';

  static const String gameDetailPath = '/game_detail';

  static const String introPage1path = '/intro_page_one';
  static const String introPage2path = '/intro_page_two';
  static const String introPage3path = '/intro_page_three';
  static const String loginPath = '/login_page';
  static const String otpPath = '/otp_page';
  static const String selectSportsPath = '/select_sports';
  static const String selectLevelPath = '/select_level';
  static const String setObjective = '/set_objective';
  static const String setName = '/set_name';
  static const String setAge = '/set_age';
  static const String setGender = '/set_gender';

  factory CustomNavigationHelper() {
    return _instance;
  }

  CustomNavigationHelper._internal() {
    final routes = [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: parentNavigatorKey,
        branches: [
          StatefulShellBranch(
            navigatorKey: homeTabNavigatorKey,
            routes: [
              GoRoute(
                path: homePath,
                pageBuilder: (context, GoRouterState state) {
                  return getPage(
                    child: const HomeScreen(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: partnersTabNavigatorKey,
            routes: [
              GoRoute(
                path: partnersPath,
                pageBuilder: (context, state) {
                  return getPage(
                    child: const PartnersScreen(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: myGamesTabNavigatorKey,
            routes: [
              GoRoute(
                path: myGamesPath,
                pageBuilder: (context, state) {
                  return getPage(
                    child: const MyGamesScreen(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: myProfileTabNavigatorKey,
            routes: [
              GoRoute(
                path: myProfilePath,
                pageBuilder: (context, state) {
                  return getPage(
                    child: const UserProfileScreen(),
                    state: state,
                  );
                },
              ),
            ],
          ),
        ],
        pageBuilder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return getPage(
            child: BottomNavigationPage(
              child: navigationShell,
            ),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: playerProfilePath,
        pageBuilder: (context, state) {
          String? playerID = state.extra as String?;
          if (playerID == null) {
            return getPage(child: const Scaffold(), state: state);
          } else {
            return getPage(
              child: PlayerProfileScreen(
                playerID: playerID,
              ),
              state: state,
            );
          }
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: splashPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const SplashScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: editProfilePath,
        pageBuilder: (context, state) {
          return getPage(
            child: const EditUserProfileScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: selectSportsPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const SelectSportsScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: gameDetailPath,
        pageBuilder: (context, state) {
          Game gameData = state.extra as Game;
          return getPage(
            child: GameDetailsPage(game: gameData),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: poshPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const PoshScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: poshInformationPath,
        pageBuilder: (context, state) {
          return getPage(state: state, child: const PoshInformationScreen());
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: poshAssessmentPath,
        pageBuilder: (context, state) {
          return getPage(state: state, child: const PoshAssessmentScreen());
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: poshResultsPath,
        pageBuilder: (context, state) {
          return getPage(state: state, child: const PoshResultsScreen());
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: myChatPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const ChatScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: introPage1path,
        pageBuilder: (context, state) {
          return getPage(
            child: const IntroOnePage(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: introPage2path,
        pageBuilder: (context, state) {
          return getPage(
            child: const IntroTwoPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: introPage3path,
        pageBuilder: (context, state) {
          return getPage(
            child: const IntroThreePage(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: loginPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const LoginScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: otpPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const OtpScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: selectSportsPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const SelectSportsScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: selectLevelPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const SetLevelScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: setObjective,
        pageBuilder: (context, state) {
          return getPage(
            child: const SetObjectiveScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: setName,
        pageBuilder: (context, state) {
          return getPage(
            child: const SetNameScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: setAge,
        pageBuilder: (context, state) {
          return getPage(
            child: const SetAgeScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: setGender,
        pageBuilder: (context, state) {
          return getPage(
            child: const SetGenderScreen(),
            state: state,
          );
        },
      ),
    ];

    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: myChatPath,
      routes: routes,
    );
  }

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }
}
