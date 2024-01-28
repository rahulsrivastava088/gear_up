import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/app_bar.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_sub_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/profile_set_up_sub_heading_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/select_objective_check_box_list_widget.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/select_playtime_check_box_list_widget%20copy.dart';
import 'package:go_router/go_router.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/intro_page_get_started_button.dart';
import 'package:provider/provider.dart';

import '../../../utils/utilities.dart';
import '../../bottomNavigation/custom.dart';
import '../viewModel/profile_set_up_view_model.dart';

class SetObjectiveScreen extends StatefulWidget {
  const SetObjectiveScreen({super.key});

  @override
  State<SetObjectiveScreen> createState() => _SetObjectiveScreen();
}

class _SetObjectiveScreen extends State<SetObjectiveScreen> {
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
            const ProfileSetUpSubHeading(
                text: Strings.objectiveOfPlayingSports),
            const SizedBox(height: 16),
            const SelectObjectiveListWidget(),
            const SizedBox(height: 34),
            const ProfileSetUpSubHeading(text: Strings.whenDoYouUsuallyPlay),
            const SizedBox(height: 16),
            const SelectPlayTimeListWidget(),
            const Spacer(),
            OnBoardingBigButton(
              onTap: () {
                if (model.selectedObjective == -1 ||
                    model.selectedPlayTime == -1) {
                  showSnackBar(context, "Please select the available options");
                } else {
                  CustomNavigationHelper.router
                      .push(CustomNavigationHelper.setName);
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
