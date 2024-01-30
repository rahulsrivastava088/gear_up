import 'package:flutter/material.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/utils/utilities.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/app_bar.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_sub_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/profile_set_up_sub_heading_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/select_level.dart';
import 'package:gear_up/view/onBoarding/viewModel/profile_set_up_view_model.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/intro_page_get_started_button.dart';
import 'package:provider/provider.dart';

import '../../../project/routes/custom_navigator.dart';

class SetLevelScreen extends StatefulWidget {
  const SetLevelScreen({super.key});

  @override
  State<SetLevelScreen> createState() => _SetLevelScreen();
}

class _SetLevelScreen extends State<SetLevelScreen> {
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
            const ProfileSetUpSubHeading(text: Strings.chooseYourFavSports),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: getList(model),
              ),
            ),
            OnBoardingBigButton(
              onTap: () {
                if (model.isLevelListValid()) {
                  CustomNavigationHelper.router
                      .push(CustomNavigationHelper.setObjectivePath);
                } else {
                  showSnackBar(context, "Please select level for each Sport!");
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

List<Widget> getList(ProfileSetUpViewModel model) {
  List<Widget> childs = [];
  int pos = 0;
  for (final index in model.selectedSports) {
    childs.add(SelectLevelWidget(index: index, model: model, pos: pos++));
    childs.add(const SizedBox(height: 16));
  }
  return childs;
}
