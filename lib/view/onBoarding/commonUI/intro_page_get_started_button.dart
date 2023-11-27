import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_constants.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:go_router/go_router.dart';

class IntroPageGetStartedButton extends StatelessWidget {
  const IntroPageGetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16, bottom: 24),
          child: InkWell(
            onTap: () {
              GoRouter.of(context).pushNamed(RouteConstants.loginPageRouteName);
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
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  Strings.getStarted,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF242424),
                    fontSize: 16,
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
