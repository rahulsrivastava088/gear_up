import 'package:flutter/material.dart';

class ProfileSetUpSubHeading extends StatelessWidget {
  final String text;
  const ProfileSetUpSubHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: 'General Sans',
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
