import 'package:flutter/material.dart';
import 'package:gear_up/view/bottomNavigation/page.dart';
import 'package:gear_up/view/home/model/response/players_list_response.dart';
import 'package:gear_up/view/home/ui/home_page_main.dart';
import 'package:gear_up/view/myGames/my_games_page_main.dart';
import 'package:gear_up/view/partners/ui/partners_page_main.dart';
import 'package:gear_up/view/userProfile/ui/player_profile/player_profile_main_page.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/own_user_page_main.dart';
import 'package:go_router/go_router.dart';

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

  static const String signUpPath = '/signUp';
  static const String signInPath = '/signIn';
  static const String detailPath = '/detail';
  static const String rootDetailPath = '/rootDetail';
  static const String playerProfilePath = '/playerProfile';

  static const String homePath = '/home';
  static const String partnersPath = '/partners';
  static const String myGamesPath = '/my_games';
  static const String myProfilePath = '/my_profile';

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
                    child: UserProfileScreen(
                      player: PlayersWithConnection(),
                    ),
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
        path: signUpPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const SignUpPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: signInPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const SignInPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        path: detailPath,
        pageBuilder: (context, state) {
          return getPage(
            child: UserProfileScreen(player: PlayersWithConnection()),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: rootDetailPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const DetailPage(),
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
    ];

    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: partnersPath,
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
