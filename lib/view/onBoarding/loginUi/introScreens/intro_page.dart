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
  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<OnBoardingViewModel>(context, listen: false).updateIntroScreen();
  // }
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<OnBoardingViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          // future: model.updateIntroScreen(true),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Stack(
              children: [
                rightHandSideTapHandler(model, context),
                leftHandSideTapHandler(model, context),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 4,
                                decoration:
                                    BoxDecoration(color: model.getColor(0)),
                              ),
                            ),
                            const SizedBox(width: 9),
                            Expanded(
                              child: Container(
                                height: 4,
                                decoration:
                                    BoxDecoration(color: model.getColor(1)),
                              ),
                            ),
                            const SizedBox(width: 9),
                            Expanded(
                              child: Container(
                                height: 4,
                                decoration:
                                    BoxDecoration(color: model.getColor(2)),
                              ),
                            )
                          ],
                        ),
                        const IntroPageImage(),
                        Container(height: 24),
                        IntroScreenHeaderText(
                          text: model.getScreenText(),
                        ),
                        const Spacer(),
                        OnBoardingBigButton(
                          text: Strings.getStarted,
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setBool(
                                SharedPreferenceConstants.introPageVisited,
                                true);
                            if (context.mounted) {
                              CustomNavigationHelper.router
                                  .go(CustomNavigationHelper.loginPath);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Positioned rightHandSideTapHandler(
      OnBoardingViewModel model, BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          print("tapped right");
          model.updateIntroScreen(true);
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          color: Colors.transparent,
        ),
      ),
    );
  }

  Positioned leftHandSideTapHandler(
      OnBoardingViewModel model, BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          print("tapped left");
          model.updateIntroScreen(false);
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          color: Colors.transparent,
        ),
      ),
    );
  }
}
