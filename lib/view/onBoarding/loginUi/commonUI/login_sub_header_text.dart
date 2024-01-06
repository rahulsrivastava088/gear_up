import 'package:flutter/material.dart';

class LoginSubHeaderText extends StatelessWidget {
  final String text;
  const LoginSubHeaderText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
