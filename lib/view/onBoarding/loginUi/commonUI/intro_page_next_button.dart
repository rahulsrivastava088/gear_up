import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';
import 'package:gear_up/utils/Strings.dart';

class IntroPageNextButton extends StatelessWidget {
  final Function onTap;
  const IntroPageNextButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            onTap();
          },
          child: Ink(
            width: double.infinity,
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: ShapeDecoration(
              color: cardBgColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                Strings.next,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
