import 'package:flutter/material.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/check_box.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/custom_snackbar.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/intro_page_get_started_button.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_sub_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/phone_number_text_field.dart';
import 'package:gear_up/view/onBoarding/loginUi/login/select_country_code.dart';
import 'package:provider/provider.dart';

import '../../viewModel/on_boarding_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController numberTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<OnBoardingViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 48, left: 24, right: 24),
          child: Column(
            children: [
              loginUI(model, context),
            ],
          ),
        ));
    // );
  }

  Column loginUI(OnBoardingViewModel model, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LoginHeaderText(text: Strings.mobileNumber),
        const SizedBox(height: 6),
        const LoginSubHeaderText(
            text: Strings.enterYourAadharLinkedMobileNumber),
        const SizedBox(height: 32),
        const SelectCountryCode(),
        const SizedBox(height: 24),
        PhoneNumber(
          textEditingController: numberTextEditingController,
        ),
        const SizedBox(height: 32),
        const Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: [
              SizedBox(height: 24, width: 24, child: LoginCheckBox()),
              SizedBox(width: 10),
              Text(
                'Get important notifications & SMS to stay updated',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Space Grotesk',
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
        const SizedBox(height: 24),
        OnBoardingBigButton(
          text: model.registerUserLoading ? 'Sending' : Strings.getOtp,
          onTap: () {
            if (numberTextEditingController.text.length != 10) {
              customSnackBar(context, 'Invalid number');
            } else {
              if (!model.registerUserLoading) {
                model.registerUser(
                  "India",
                  numberTextEditingController.text,
                  context,
                );
              }
            }
          },
        )
      ],
    );
  }
}
