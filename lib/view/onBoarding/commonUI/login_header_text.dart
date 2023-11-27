import 'package:flutter/material.dart';

class LoginHeaderText extends StatelessWidget {
  final String text;
  const LoginHeaderText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontFamily: 'General Sans',
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
