import 'package:flutter/material.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/intro_page_get_started_button.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/intro_page_image.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/intro_page_text.dart';
import 'package:gear_up/view/onBoarding/viewModel/on_boarding_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/shared_preferences.dart';
import '../../../../project/routes/custom_navigator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<OnBoardingViewModel>(context);

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity! > 0) {
            model.updateIntroScreen(false);
          } else if (details.primaryVelocity! < 0) {
            model.updateIntroScreen(true);
          }
        },
        child: Stack(children: [
          coverWholeScreenForSwiping(model, context),
          SafeArea(
              child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const IntroPageImage(),
                  Container(height: 24),
                  IntroScreenHeaderText(
                    text: model.getScreenText(),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: model.getSize(0),
                        width: model.getSize(0),
                        decoration: BoxDecoration(
                            color: model.getColor(0), shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 9),
                      Container(
                        height: model.getSize(1),
                        width: model.getSize(1),
                        decoration: BoxDecoration(
                            color: model.getColor(1), shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 9),
                      Container(
                        height: model.getSize(2),
                        width: model.getSize(2),
                        decoration: BoxDecoration(
                            color: model.getColor(2), shape: BoxShape.circle),
                      ),
                    ],
                  ),
                  OnBoardingBigButton(
                    text: Strings.getStarted,
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool(
                          SharedPreferenceConstants.introPageVisited, true);
                      if (context.mounted) {
                        CustomNavigationHelper.router
                            .go(CustomNavigationHelper.loginPath);
                      }
                    },
                  )
                ],
              ),
            ),
          )),
        ]),
      ),
    );
  }

  Positioned coverWholeScreenForSwiping(
      OnBoardingViewModel model, BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
      ),
    );
  }
}
