import 'package:flutter/material.dart';
import 'package:gear_up/view/userProfile/userDetails/star_display.dart';

class RatingCard extends StatelessWidget {
  const RatingCard({
    super.key,
    required this.userRating,
  });

  final double userRating;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: const Color(0xFF141414),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ratings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'General Sans',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$userRating/5',
                style: const TextStyle(
                  color: Color(0xFFCBCBCB),
                  fontSize: 12,
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.w400,
                ),
              ),
              StarRating(starCount: 5, rating: userRating, color: Colors.yellow)
            ],
          )
        ],
      ),
    );
  }
}
