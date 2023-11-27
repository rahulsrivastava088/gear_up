import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/commonUI/back_icon.dart';
import 'package:gear_up/view/onBoarding/commonUI/check_box.dart';
import 'package:gear_up/view/onBoarding/commonUI/get_otp_button.dart';
import 'package:gear_up/view/onBoarding/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/login_sub_header_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/phone_number_text_field.dart';
import 'package:gear_up/view/onBoarding/commonUI/select_country_code.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 71, left: 24, right: 24),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackIcon(),
            const SizedBox(height: 24),
            const LoginHeaderText(text: Strings.mobileNumber),
            const SizedBox(height: 6),
            const LoginSubHeaderText(
                text: Strings.enterYourAadharLinkedMobileNumber),
            const SizedBox(height: 32),
            const SelectCountryCode(),
            const SizedBox(height: 24),
            const PhoneNumber(),
            const SizedBox(height: 32),
            const Padding(
              padding:
                  EdgeInsetsDirectional.symmetric(horizontal: 4, vertical: 8),
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
            GetOtpButton(
              onTap: () {
                GoRouter.of(context).pushNamed(RouteConstants.otpPageRouteName);
              },
            )
          ],
        ),
      ),
    );
  }
}
