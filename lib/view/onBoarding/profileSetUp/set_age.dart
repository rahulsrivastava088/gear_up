import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/commonUI/back_icon.dart';

import 'package:gear_up/view/onBoarding/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/login_sub_header_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/onBoarding_big_button.dart';
import 'package:gear_up/view/onBoarding/commonUI/onboarding_custom_text_field.dart';
import 'package:gear_up/view/onBoarding/commonUI/profile_set_up_sub_heading_text.dart';
import 'package:go_router/go_router.dart';

class SetAgeScreen extends StatefulWidget {
  const SetAgeScreen({super.key});

  @override
  State<SetAgeScreen> createState() => _SetAgeScreen();
}

class _SetAgeScreen extends State<SetAgeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 71, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackIcon(),
            const SizedBox(height: 24),
            const LoginHeaderText(text: Strings.setUpProfile),
            const SizedBox(height: 6),
            const LoginSubHeaderText(text: Strings.findBestPartnersNearYou),
            const SizedBox(height: 32),
            const ProfileSetUpSubHeading(text: Strings.whatsYourAge),
            const SizedBox(height: 16),
            const CustomTextField(hintText: 'DD/MM/YYYY'),
            const Spacer(),
            OnBoardingBigButton(
              onTap: () {
                GoRouter.of(context)
                    .pushNamed(RouteConstants.setGenderPageRouteName);
              },
              text: Strings.next,
            ),
            const SizedBox(height: 24)
          ],
        ),
      ),
    );
  }
}
