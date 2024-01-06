import 'package:flutter/material.dart';

class OTPStatusText extends StatefulWidget {
  final String message;
  final Color color;
  final FontWeight fontWeight;
  final Function onTap;
  const OTPStatusText(
      {super.key,
      required this.message,
      required this.color,
      required this.fontWeight,
      required this.onTap});

  @override
  State<OTPStatusText> createState() => _OTPStatusText();
}

class _OTPStatusText extends State<OTPStatusText> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Ink(
        child: Text(
          widget.message,
          style: TextStyle(
            color: widget.color,
            fontSize: 12,
            fontFamily: 'Space Grotesk',
            fontWeight: widget.fontWeight,
          ),
        ),
      ),
    );
  }
}
