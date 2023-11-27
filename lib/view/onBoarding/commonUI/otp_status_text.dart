import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class OTPStatusText extends StatefulWidget {
  final String message;
  const OTPStatusText({super.key, required this.message});

  @override
  State<OTPStatusText> createState() => _OTPStatusText();
}

class _OTPStatusText extends State<OTPStatusText> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: widget.message,
        style: const TextStyle(
          color: Color(0xFF0095F6),
          fontSize: 12,
          fontFamily: 'Space Grotesk',
          fontWeight: FontWeight.w400,
        ),
        recognizer: TapGestureRecognizer()..onTap = () {},
      ),
    );
  }
}
