import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/check_box.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/custom_snackbar.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_sub_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/phone_number_text_field.dart';
import 'package:gear_up/view/onBoarding/loginUi/login/select_country_code.dart';
import 'package:jumping_dot/jumping_dot.dart';
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
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: InkWell(
            onTap: () {
              if (numberTextEditingController.text.isEmpty) {
                customSnackBar(context, 'Invalid number');
              } else {
                if (!model.registerUserLoading) {
                  model.registerUser(
                    model.selectedCountryCode,
                    numberTextEditingController.text,
                    context,
                  );
                }
              }
            },
            child: Ink(
              width: double.infinity,
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: model.registerUserLoading == false
                  ? const Align(
                      alignment: Alignment.center,
                      child: Text(Strings.getOtp,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF242424),
                            fontSize: 16,
                            fontFamily: 'General Sans',
                            fontWeight: FontWeight.bold,
                          )),
                    )
                  : JumpingDots(
                      color: Colors.grey,
                      radius: 10,
                      numberOfDots: 5,
                    ),
            ),
          ),
        )
      ],
    );
  }
}
