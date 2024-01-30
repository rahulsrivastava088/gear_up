import 'package:flutter/material.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/utils/utilities.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/app_bar.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_sub_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/profile_set_up_sub_heading_text.dart';
import 'package:gear_up/view/onBoarding/viewModel/profile_set_up_view_model.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/intro_page_get_started_button.dart';
import 'package:provider/provider.dart';
import '../../../project/routes/custom_navigator.dart';
import '../loginUi/commonUI/onboarding_custom_text_field.dart';

class SetNameScreen extends StatefulWidget {
  const SetNameScreen({super.key});

  @override
  State<SetNameScreen> createState() => _SetNameScreen();
}

class _SetNameScreen extends State<SetNameScreen> {
  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Listen to focus changes and unfocus the other TextField
    _firstNameFocusNode.addListener(() {
      if (_firstNameFocusNode.hasFocus) {
        _lastNameFocusNode.unfocus();
      }
    });

    _lastNameFocusNode.addListener(() {
      if (_lastNameFocusNode.hasFocus) {
        _firstNameFocusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

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
            const ProfileSetUpSubHeading(text: Strings.whatsYourName),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: CustomTextField(
                  hintText: 'First',
                  textEditingController: firstNameEditingController,
                  focusNode: _firstNameFocusNode,
                )),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    hintText: 'Last',
                    textEditingController: lastNameEditingController,
                    focusNode: _lastNameFocusNode,
                  ),
                )
              ],
            ),
            const Spacer(),
            OnBoardingBigButton(
              onTap: () {
                model.firstName = firstNameEditingController.text.toString();
                model.lastName = lastNameEditingController.text.toString();
                if (model.firstName.isNotEmpty && model.lastName.isNotEmpty) {
                  CustomNavigationHelper.router
                      .push(CustomNavigationHelper.setAgePath);
                } else {
                  showSnackBar(context, 'Please enter proper name');
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
