import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/commonUI/app_bar.dart';
import 'package:gear_up/view/onBoarding/commonUI/back_icon.dart';
import 'package:gear_up/view/onBoarding/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/login_sub_header_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/onBoarding_big_button.dart';
import 'package:gear_up/view/onBoarding/commonUI/profile_set_up_sub_heading_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/select_sports_check_box.dart';
import 'package:go_router/go_router.dart';

class SelectSportsScreen extends StatefulWidget {
  const SelectSportsScreen({super.key});

  @override
  State<SelectSportsScreen> createState() => _SelectSportsScreenState();
}

class _SelectSportsScreenState extends State<SelectSportsScreen> {
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
            const ProfileSetUpSubHeading(text: Strings.chooseYourFavSports),
            const SizedBox(height: 16),
            Column(
              children: getList(),
            ),
            const Spacer(),
            OnBoardingBigButton(
              onTap: () {
                GoRouter.of(context)
                    .pushNamed(RouteConstants.selectLevelPageRouteName);
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

List<Widget> getList() {
  List<Widget> childs = [];
  for (final sport in Strings.sportsList) {
    childs.add(SelectSportsCheckBox(text: sport));
    childs.add(const SizedBox(height: 12));
  }
  return childs;
}
