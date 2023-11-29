import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/commonUI/app_bar.dart';
import 'package:gear_up/view/onBoarding/commonUI/back_icon.dart';
import 'package:gear_up/view/onBoarding/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/login_sub_header_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/onBoarding_big_button.dart';
import 'package:gear_up/view/onBoarding/commonUI/onBoarding_custom_text_field.dart';
import 'package:gear_up/view/onBoarding/commonUI/profile_set_up_sub_heading_text.dart';
import 'package:go_router/go_router.dart';

class SetNameScreen extends StatefulWidget {
  const SetNameScreen({super.key});

  @override
  State<SetNameScreen> createState() => _SetNameScreen();
}

class _SetNameScreen extends State<SetNameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: onBoardingAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LoginHeaderText(text: Strings.setUpProfile),
            const SizedBox(height: 6),
            const LoginSubHeaderText(text: Strings.findBestPartnersNearYou),
            const SizedBox(height: 32),
            const ProfileSetUpSubHeading(text: Strings.whatsYourName),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(
                    child: CustomTextField(
                  hintText: 'First',
                )),
                SizedBox(width: 12),
                Expanded(
                    child: CustomTextField(
                  hintText: 'Last',
                ))
              ],
            ),
            const Spacer(),
            OnBoardingBigButton(
              onTap: () {
                GoRouter.of(context)
                    .pushNamed(RouteConstants.setAgePageRouteName);
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
