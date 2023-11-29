import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/commonUI/app_bar.dart';
import 'package:gear_up/view/onBoarding/commonUI/custom_snackbar.dart';
import 'package:gear_up/view/onBoarding/commonUI/intro_page_get_started_button.dart';
import 'package:gear_up/view/onBoarding/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/login_sub_header_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/otp_status_text.dart';
import 'package:gear_up/view/onBoarding/commonUI/otp_text_field.dart';
import 'package:go_router/go_router.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: onBoardingAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LoginHeaderText(text: Strings.enterOtp),
            const SizedBox(height: 6),
            const LoginSubHeaderText(text: Strings.otpSentText),
            const SizedBox(height: 32),
            OTPTextField(textEditingController: otpTextEditingController),
            const SizedBox(height: 12),
            const OTPStatusText(message: 'Resend OTP'),
            const SizedBox(height: 24),
            OnBoardingBigButton(
              onTap: () {
                if (otpTextEditingController.text.isNotEmpty) {
                  GoRouter.of(context)
                      .pushNamed(RouteConstants.selectSportsPageRouteName);
                } else {
                  customSnackBar(context, 'Enter OTP');
                }
              },
              text: Strings.verify,
            )
          ],
        ),
      ),
    );
  }
}
