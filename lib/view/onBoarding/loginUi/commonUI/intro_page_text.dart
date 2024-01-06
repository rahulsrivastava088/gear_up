import 'package:flutter/material.dart';

class IntroScreenHeaderText extends StatelessWidget {
  final String text;
  const IntroScreenHeaderText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontFamily: 'General Sans',
          fontWeight: FontWeight.w600,
          letterSpacing: 0.42,
        ),
      ),
    );
  }
}
