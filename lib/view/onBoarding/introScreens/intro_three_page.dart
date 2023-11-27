import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/commonUI/intro_page_get_started_button.dart';
import 'package:gear_up/view/onBoarding/commonUI/intro_page_image.dart';
import 'package:gear_up/view/onBoarding/commonUI/intro_page_next_button.dart';
import 'package:gear_up/view/onBoarding/commonUI/intro_page_text.dart';
import 'package:go_router/go_router.dart';

class IntroThreePage extends StatelessWidget {
  const IntroThreePage({super.key});

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
                text: Strings.introScreen3HeaderText,
              ),
              const Spacer(),
              IntroPageNextButton(
                onTap: () {
                  GoRouter.of(context)
                      .pushNamed(RouteConstants.loginPageRouteName);
                },
              ),
              const IntroPageGetStartedButton()
            ],
          ),
        ),
      ),
    );
  }
}
