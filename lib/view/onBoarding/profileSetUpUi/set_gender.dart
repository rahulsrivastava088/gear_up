import 'package:flutter/material.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/app_bar.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_sub_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/profile_set_up_sub_heading_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/intro_page_get_started_button.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/select_gender_check_box_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/shared_preferences.dart';
import '../../../utils/utilities.dart';
import '../../../project/routes/custom_navigator.dart';
import '../viewModel/profile_set_up_view_model.dart';

class SetGenderScreen extends StatefulWidget {
  const SetGenderScreen({super.key});

  @override
  State<SetGenderScreen> createState() => _SetGenderScreen();
}

class _SetGenderScreen extends State<SetGenderScreen> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProfileSetUpViewModel>(context);

    return Scaffold(
      appBar: onBoardingAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: ui(model, context),
      ),
    );
  }

  Column ui(ProfileSetUpViewModel model, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LoginHeaderText(text: Strings.setUpProfile),
        const SizedBox(height: 6),
        const LoginSubHeaderText(text: Strings.findBestPartnersNearYou),
        const SizedBox(height: 32),
        const ProfileSetUpSubHeading(text: Strings.whatsYourGender),
        const SizedBox(height: 16),
        const SelectGenderListWidget(),
        const Spacer(),
        OnBoardingBigButton(
          onTap: () {
            if (model.selectedGender == -1) {
              showSnackBar(context, "Please select gender");
            } else {
              CustomNavigationHelper.router
                  .push(CustomNavigationHelper.setProfilePicturePath);
            }
          },
          text: Strings.next,
        ),
        const SizedBox(height: 24)
      ],
    );
  }
}
