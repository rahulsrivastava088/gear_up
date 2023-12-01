import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';

class SocialMediaCard extends StatelessWidget {
  final String text;
  final IconData icon;
  const SocialMediaCard({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: cardBgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFCBCBCB),
              fontSize: 12,
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          const Icon(Icons.add_circle_outline_outlined)
        ],
      ),
    );
  }
}
