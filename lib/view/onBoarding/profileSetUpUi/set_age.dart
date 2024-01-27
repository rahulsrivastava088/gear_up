import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/age_text_field.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/app_bar.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_sub_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/intro_page_get_started_button.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/profile_set_up_sub_heading_text.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../utils/utilities.dart';
import '../../bottomNavigation/custom.dart';
import '../viewModel/profile_set_up_view_model.dart';

class SetAgeScreen extends StatefulWidget {
  const SetAgeScreen({super.key});

  @override
  State<SetAgeScreen> createState() => _SetAgeScreen();
}

class _SetAgeScreen extends State<SetAgeScreen> {
  TextEditingController ageTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProfileSetUpViewModel>(context);

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
            const ProfileSetUpSubHeading(text: 'What\'s your date of birth?'),
            const SizedBox(height: 16),
            Expanded(
              child: AgeTextField(
                hintText: 'DD/MM/YYYY',
                textEditingController: ageTextEditingController,
              ),
            ),
            const Spacer(),
            OnBoardingBigButton(
              onTap: () {
                model.dob = ageTextEditingController.text.toString();
                if (model.isValidDate(model.dob)) {
                  CustomNavigationHelper.router
                      .push(CustomNavigationHelper.setGender);
                } else {
                  showSnackBar(context, 'Please enter proper date of birth');
                }
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
