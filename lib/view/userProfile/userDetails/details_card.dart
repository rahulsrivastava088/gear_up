import 'package:flutter/material.dart';

class UserDetailsCard extends StatelessWidget {
  const UserDetailsCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.userAge,
    required this.userGender,
    required this.userLocation,
  });

  final String userImage;
  final String userName;
  final String userAge;
  final String userGender;
  final String userLocation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(80), // Image radius
              child: Image.network(userImage, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            userName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontFamily: 'General Sans',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$userAge, $userGender',
                  style: const TextStyle(
                      color: Color(0xFFCBCBCB),
                      fontSize: 12,
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(width: 8),
                const VerticalDivider(
                  color: Color(0xFFCBCBCB),
                  thickness: 1,
                ),
                const SizedBox(width: 8),
                Text(
                  userLocation,
                  style: const TextStyle(
                    color: Color(0xFFCBCBCB),
                    fontSize: 12,
                    fontFamily: 'Space Grotesk',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 34)
        ],
      ),
    );
  }
}
