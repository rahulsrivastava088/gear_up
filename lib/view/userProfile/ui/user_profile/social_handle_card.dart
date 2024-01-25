import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';

import '../../../../utils/utilities.dart';

class SocialMediaCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isEditable;
  final String? link;
  const SocialMediaCard({
    super.key,
    required this.text,
    required this.icon,
    required this.isEditable,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (link != null) {
          hitSocialMediaLink(link!);
        }
      },
      child: Container(
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
            isEditable
                ? const Icon(Icons.add_circle_outline_outlined, size: 20)
                : link == null
                    ? const Icon(Icons.error_outline_rounded,
                        size: 20, color: Colors.grey)
                    : const Icon(Icons.north_east, size: 20)
          ],
        ),
      ),
    );
  }
}
