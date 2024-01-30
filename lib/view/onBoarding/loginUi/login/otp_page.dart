import 'package:flutter/material.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/app_bar.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/custom_snackbar.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/intro_page_get_started_button.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_sub_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/otp_status_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/otp_text_field.dart';
import 'package:gear_up/view/onBoarding/viewModel/on_boarding_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpTextEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<OnBoardingViewModel>(context);
    return Scaffold(
      appBar: onBoardingAppBar(
        context,
        onTap: () {
          model.resetOTPPageData();
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: otpScreenUI(model, context),
      ),
    );
  }

  Column otpScreenUI(OnBoardingViewModel model, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LoginHeaderText(text: Strings.enterOtp),
        const SizedBox(height: 6),
        LoginSubHeaderText(
            text:
                '${Strings.otpSentText}${model.registerUserBody.mobileNumber ?? 'Your Mobile Number'}'),
        const SizedBox(height: 32),
        OTPTextField(textEditingController: otpTextEditingController),
        const SizedBox(height: 12),
        OTPStatusText(
          message: model.isResendVisible
              ? 'Resend OTP'
              : "Resend OTP ( in ${model.remainingSeconds} sec )",
          color: model.isResendVisible
              ? const Color(0xFF0095F6)
              : const Color(0xFFAFAFAF),
          fontWeight: model.isResendVisible ? FontWeight.w500 : FontWeight.w400,
          onTap: () {
            if (model.isResendVisible) {
              model.resendOtp(context);
            }
          },
        ),
        const SizedBox(height: 24),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: InkWell(
            onTap: () {
              if (otpTextEditingController.text.isEmpty) {
                customSnackBar(context, 'Please enter OTP');
              } else {
                if (!model.verifyUserLoading) {
                  model.verifyUser(context, otpTextEditingController.text);
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
              child: model.verifyUserLoading == false
                  ? const Align(
                      alignment: Alignment.center,
                      child: Text(Strings.verify,
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
        // ,OnBoardingBigButton(
        //       text: model.verifyUserLoading ? 'Verifying' : Strings.verify,
        //       onTap: () {
        //         if (otpTextEditingController.text.isEmpty) {
        //           customSnackBar(context, 'Please enter OTP');
        //         } else {
        //           if (!model.verifyUserLoading) {
        //             model.verifyUser(context, otpTextEditingController.text);
        //           }
        //         }
        //       })
      ],
    );
  }
}
