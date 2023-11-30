import 'package:flutter/material.dart';
import 'package:gear_up/view/userProfile/userDetails/about_card.dart';
import 'package:gear_up/view/userProfile/userDetails/app_bar.dart';
import 'package:gear_up/view/userProfile/userDetails/details_card.dart';
import 'package:gear_up/view/userProfile/userDetails/plays_card.dart';
import 'package:gear_up/view/userProfile/userDetails/profession_card.dart';
import 'package:gear_up/view/userProfile/userDetails/ratings_card.dart';
import 'package:gear_up/view/userProfile/userDetails/social_handle_card.dart';
import 'package:gear_up/view/userProfile/userDetails/stats_card.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String userName = 'Amélie';
  String userImage =
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww';
  String userAge = '23';
  String userGender = 'Female';
  String userLocation = 'Paris';
  double userRating = 3.5;
  List<String> sportsUserPlays = ['Pool, Table Tennis'];
  String userAbout = 'Part time Vionilist';
  String userProfession = 'Horse Trainer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: userProfileAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 48, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserDetailsCard(
                  userImage: userImage,
                  userName: userName,
                  userAge: userAge,
                  userGender: userGender,
                  userLocation: userLocation,
                ),
                RatingCard(userRating: userRating),
                const SizedBox(height: 8),
                PlaysCard(
                  sportslist: sportsUserPlays,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                AboutCard(text: userAbout, onTap: () {}),
                const SizedBox(height: 8),
                ProfessionCard(text: userProfession, onTap: () {}),
                const SizedBox(height: 32),
                const Text(
                  'Games Stats',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                const ExpandedTile(
                    sportsName: 'Squash',
                    played: '9',
                    won: '6',
                    rate: 'Mai expert hoon'),
                const ExpandedTile(
                    sportsName: 'Kuch Kuch',
                    played: '10',
                    won: '4',
                    rate: 'Bilkul'),
                const ExpandedTile(
                    sportsName: 'Nope',
                    played: '2',
                    won: '3',
                    rate: 'Yeah, nope'),
                const SizedBox(height: 32),
                const Text(
                  'Social Media',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                const SocialMediaCard(text: 'Facebook', icon: Icons.facebook),
                const SizedBox(height: 8),
                const SocialMediaCard(text: 'Instagram', icon: Icons.facebook),
                const SizedBox(height: 8),
                const SocialMediaCard(text: 'Linkedin', icon: Icons.facebook),
                const SizedBox(height: 8),
                const SocialMediaCard(text: 'X(Twitter)', icon: Icons.facebook),
                const SizedBox(height: 8),
                const SizedBox(height: 32),
                const Text(
                  'Reviews and Ratings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ));
  }
}
