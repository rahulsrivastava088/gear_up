import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gear_up/colors/colors.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/utils/uiUtils/big_button.dart';
import 'package:gear_up/view/bottomNavigation/custom.dart';
import 'package:go_router/go_router.dart';

class PoshScreen extends StatefulWidget {
  const PoshScreen({super.key});

  @override
  State<PoshScreen> createState() => _PoshScreenState();
}

class _PoshScreenState extends State<PoshScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: poshAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    poshImage(),
                    const SizedBox(height: 40),
                    poshTrainingHeaderText(),
                    const SizedBox(height: 40),
                    whatIsPoshTrainingCard(),
                  ],
                ),
              ),
              const Spacer(),
              CustomBigButtonLight(
                  onTap: () {
                    CustomNavigationHelper.router
                        .push(CustomNavigationHelper.poshInformationPath);
                  },
                  text: "Let's Start"),
              const SizedBox(height: 32)
            ],
          ),
        ));
  }

  Container whatIsPoshTrainingCard() {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: cardBgColorLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            Strings.whatIsPoshTraining,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            Strings.whatIsPoshTrainingText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFF333333)),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/posh/ic_safespace_advocate_badge.svg'),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  Strings.earnBadgeText,
                  style: TextStyle(
                    color: Color(0xFFAFAFAF),
                    fontSize: 14,
                    fontFamily: 'Space Grotesk',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Center poshTrainingHeaderText() {
    return const Center(
      child: Column(children: [
        Text(
          "POSH TRAINING",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontFamily: 'General Sans',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6),
        Text(
          "Empowering Respectful Spaces",
          style: TextStyle(
            color: Color(0xFFCBCBCB),
            fontSize: 14,
            fontFamily: 'Space Grotesk',
            fontWeight: FontWeight.w400,
          ),
        ),
      ]),
    );
  }

  Widget poshImage() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: SvgPicture.asset(
        'assets/posh/ic_posh_illustration.svg',
        height: 200,
      ),
    );
  }

  AppBar poshAppBar() {
    return AppBar(
      titleSpacing: 24.0,
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 32,
          ),
        ),
      ),
    );
  }
}
