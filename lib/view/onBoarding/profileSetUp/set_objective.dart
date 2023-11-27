import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/commonUI/back_icon.dart';
import 'package:gear_up/view/onBoarding/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/login_sub_header_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/onBoarding_big_button.dart';
import 'package:gear_up/view/onBoarding/commonUI/profile_set_up_sub_heading_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/select_level_check_box.dart';
import 'package:go_router/go_router.dart';

class SetObjectiveScreen extends StatefulWidget {
  const SetObjectiveScreen({super.key});

  @override
  State<SetObjectiveScreen> createState() => _SetObjectiveScreen();
}

class _SetObjectiveScreen extends State<SetObjectiveScreen> {
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
            const ProfileSetUpSubHeading(
                text: Strings.objectiveOfPlayingSports),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 8,
              runSpacing: 6,
              children: getObjectiveWidgetList(),
            ),
            const SizedBox(height: 34),
            const ProfileSetUpSubHeading(text: Strings.whenDoYouUsuallyPlay),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 8,
              runSpacing: 6,
              children: getPlayingTimeWidgetList(),
            ),
            const Spacer(),
            OnBoardingBigButton(
              onTap: () {
                GoRouter.of(context)
                    .pushNamed(RouteConstants.setNamePageRouteName);
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

List<Widget> getObjectiveWidgetList() {
  List<Widget> childs = [];
  for (final sport in Strings.playingObjectiveList) {
    childs.add(CustomCheckBox(text: sport));
  }
  return childs;
}

List<Widget> getPlayingTimeWidgetList() {
  List<Widget> childs = [];
  for (final sport in Strings.playingTimeList) {
    childs.add(CustomCheckBox(text: sport));
  }
  return childs;
}
