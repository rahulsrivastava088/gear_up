import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/intro_page_get_started_button.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/intro_page_image.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/intro_page_next_button.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/intro_page_text.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/shared_preferences.dart';

class IntroTwoPage extends StatelessWidget {
  const IntroTwoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IntroPageImage(),
              Container(height: 24),
              const IntroScreenHeaderText(
                text: Strings.introScreen2HeaderText,
              ),
              const Spacer(),
              IntroPageNextButton(
                onTap: () {
                  GoRouter.of(context)
                      .pushNamed(RouteConstants.introPage3RouteName);
                },
              ),
              OnBoardingBigButton(
                text: Strings.getStarted,
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool(
                      SharedPreferenceConstants.introPageVisited, true);
                  if (context.mounted) {
                    GoRouter.of(context)
                        .goNamed(RouteConstants.loginPageRouteName);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
