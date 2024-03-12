import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:gear_up/utils/shared_preferences.dart';
import 'package:gear_up/project/routes/custom_navigator.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => CheckBaseActionState();
}

class CheckBaseActionState extends State<SplashScreen> with AfterLayoutMixin {
  Future checkFirstSeen() async {
    await Future.delayed(const Duration(seconds: 2));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceConstants.token);
    // ??"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTk1N2M5MTNiOGU1NjNhYzEzNDRhM2QiLCJpYXQiOjE3MDQyOTU1Njl9.NWThEs1bbrtCTNyzJtB9IS0DuRzJbEsc6nc0QGQ5F4I";
    if (token != null) {
      bool isNewUser =
          prefs.getBool(SharedPreferenceConstants.isNewUser) ?? false;

      if (isNewUser) {
        moveToScreen(CustomNavigationHelper.selectSportsPath);
      } else {
        moveToScreen(CustomNavigationHelper.homePath);
      }
    } else {
      bool introScreenVisited =
          (prefs.getBool(SharedPreferenceConstants.introPageVisited) ?? false);

      if (introScreenVisited) {
        moveToScreen(CustomNavigationHelper.loginPath);
      } else {
        moveToScreen(CustomNavigationHelper.introPagePath);
      }
    }
  }

  void moveToScreen(String routeName) {
    if (mounted) {
      CustomNavigationHelper.router.go(routeName);
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
    return Column(
      children: [
        Lottie.asset(
          'assets/lottie/gear_up_lottie_animation.json',
          width: 400,
          height: 400,
          repeat: false,
        )
      ],
    );
  }
}
