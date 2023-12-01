import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';
import 'package:gear_up/view/userProfile/userDetails/star_display.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String image;
  final String date;
  final String review;
  final double rating;
  const ReviewCard({
    super.key,
    required this.name,
    required this.image,
    required this.date,
    required this.review,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 12,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      decoration: ShapeDecoration(
        color: cardBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(24), // Image radius
                  child: Image.network(image, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'General Sans',
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      color: Color(0xFFCBCBCB),
                      fontSize: 12,
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              StarRating(starCount: 5, rating: rating, color: Colors.yellow)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 64),
            child: Text(
              review,
              style: const TextStyle(
                color: Color(0xFFCBCBCB),
                fontSize: 12,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
