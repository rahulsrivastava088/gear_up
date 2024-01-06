import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/utils/utilities.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/intro_page_get_started_button.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_sub_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/profile_set_up_sub_heading_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/select_sports_check_box.dart';
import 'package:gear_up/view/onBoarding/viewModel/profile_set_up_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SelectSportsScreen extends StatefulWidget {
  const SelectSportsScreen({super.key});

  @override
  State<SelectSportsScreen> createState() => _SelectSportsScreenState();
}

class _SelectSportsScreenState extends State<SelectSportsScreen> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProfileSetUpViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
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
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: getList(model),
            ),
            const Spacer(),
            OnBoardingBigButton(
              onTap: () {
                if (model.selectedSports.isEmpty) {
                  showSnackBar(context, "Please select at least 1 Sport");
                } else {
                  GoRouter.of(context)
                      .pushNamed(RouteConstants.selectLevelPageRouteName);
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
  for (int i = 0; i < Strings.sportsList.length; i++) {
    childs.add(SelectSportsCheckBox(index: i, model: model));
    childs.add(const SizedBox(height: 12));
  }
  return childs;
}
