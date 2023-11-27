import 'package:flutter/material.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/commonUI/back_icon.dart';
import 'package:gear_up/view/onBoarding/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/login_sub_header_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/onBoarding_big_button.dart';
import 'package:gear_up/view/onBoarding/commonUI/profile_set_up_sub_heading_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/select_level_check_box.dart';

class SetGenderScreen extends StatefulWidget {
  const SetGenderScreen({super.key});

  @override
  State<SetGenderScreen> createState() => _SetGenderScreen();
}

class _SetGenderScreen extends State<SetGenderScreen> {
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
            const ProfileSetUpSubHeading(text: Strings.whatsYourGender),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 8,
              runSpacing: 6,
              children: getGenderWidgetList(),
            ),
            const Spacer(),
            OnBoardingBigButton(
              onTap: () {},
              text: Strings.next,
            ),
            const SizedBox(height: 24)
          ],
        ),
      ),
    );
  }
}

List<Widget> getGenderWidgetList() {
  List<Widget> childs = [];
  for (final gender in Strings.genderList) {
    childs.add(CustomCheckBox(text: gender));
  }
  return childs;
}
