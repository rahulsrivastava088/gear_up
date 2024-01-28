import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/star_display.dart';

import '../../model/response/player_profile_response.dart';

class ReviewCard extends StatelessWidget {
  final Rating rating;
  const ReviewCard({
    super.key,
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
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/person_image.png',
                    image: rating.img ?? '',
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/images/person_image.png",
                        width: 100,
                        height: 100,
                      );
                    },
                  ),
                  // rating.img, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rating.name ?? '-',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'General Sans',
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    convertDate(rating.reviewDate) ?? '-',
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
              StarRating(
                  starCount: 5,
                  rating: rating.rating?.toDouble() ?? 0.0,
                  color: Colors.yellow)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 64),
            child: Text(
              rating.reviewMessage ?? '-',
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
