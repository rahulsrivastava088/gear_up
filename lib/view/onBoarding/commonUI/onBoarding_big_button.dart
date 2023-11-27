import 'package:flutter/material.dart';

class OnBoardingBigButton extends StatelessWidget {
  final String text;
  final Function onTap;
  const OnBoardingBigButton(
      {super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          // color: Colors.white,
          height: 48,
          // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Align(
            alignment: Alignment.center,
            child: TextButton(
              // style: TextButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                onTap();
              },
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
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
