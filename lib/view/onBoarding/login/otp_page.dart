import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/commonUI/back_icon.dart';
import 'package:gear_up/view/onBoarding/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/login_sub_header_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/otp_status_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/otp_text_field.dart';
import 'package:gear_up/view/onBoarding/commonUI/onBoarding_big_button.dart';
import 'package:go_router/go_router.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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
            const LoginHeaderText(text: Strings.enterOtp),
            const SizedBox(height: 6),
            const LoginSubHeaderText(text: Strings.otpSentText),
            const SizedBox(height: 32),
            const OTPTextField(),
            const SizedBox(height: 12),
            const OTPStatusText(message: 'Resend OTP'),
            const SizedBox(height: 24),
            OnBoardingBigButton(
              onTap: () {
                GoRouter.of(context)
                    .pushNamed(RouteConstants.selectSportsPageRouteName);
              },
              text: Strings.verify,
            )
          ],
        ),
      ),
    );
  }
}
