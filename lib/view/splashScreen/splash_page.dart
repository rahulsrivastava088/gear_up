import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/utils/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => CheckBaseActionState();
}

class CheckBaseActionState extends State<SplashScreen> with AfterLayoutMixin {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token);
    if (token != null) {
      bool isNewUser =
          prefs.getBool(SharedPreferenceConstants.isNewUser) ?? false;

      if (isNewUser) {
        moveToScreen(RouteConstants.selectSportsPageRouteName);
      } else {
        moveToScreen(RouteConstants.homePageRouteName);
      }
    } else {
      bool introScreenVisited =
          (prefs.getBool(SharedPreferenceConstants.introPageVisited) ?? false);

      if (introScreenVisited) {
        moveToScreen(RouteConstants.loginPageRouteName);
      } else {
        moveToScreen(RouteConstants.introPage1RouteName);
      }
    }
  }

  void moveToScreen(String routeName) {
    if (mounted) {
      GoRouter.of(context).goNamed(routeName);
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SplashScreenText()],
        ),
      ),
    );
  }
}

class SplashScreenText extends StatelessWidget {
  const SplashScreenText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      Strings.splashScreenText,
      style: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontStyle: FontStyle.italic,
        fontFamily: 'General Sans',
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
