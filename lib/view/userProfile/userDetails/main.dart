import 'package:flutter/material.dart';
import 'package:gear_up/view/userProfile/userDetails/about_card.dart';
import 'package:gear_up/view/userProfile/userDetails/app_bar.dart';
import 'package:gear_up/view/userProfile/userDetails/details_card.dart';
import 'package:gear_up/view/userProfile/userDetails/edit_about_bottom_sheet.dart';
import 'package:gear_up/view/userProfile/userDetails/edit_play_bottom_sheet.dart';
import 'package:gear_up/view/userProfile/userDetails/edit_profession_bottom_sheet.dart';
import 'package:gear_up/view/userProfile/userDetails/plays_card.dart';
import 'package:gear_up/view/userProfile/userDetails/profession_card.dart';
import 'package:gear_up/view/userProfile/userDetails/ratings_card.dart';
import 'package:gear_up/view/userProfile/userDetails/review_card.dart';
import 'package:gear_up/view/userProfile/userDetails/social_handle_card.dart';
import 'package:gear_up/view/userProfile/userDetails/stats_card.dart';
import 'package:gear_up/view/userProfile/userDetails/title_text.dart';

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
  String reviewer1Image =
      'https://i.insider.com/579f9175d7c3dbe72f8b47f8?width=1000&format=jpeg&auto=webp';
  String reviewer1Name = 'Harry Potter';
  String review1Date = '31 July 1980';
  String review1 = 'I Love Magic';
  double review1Rating = 4.5;
  String reviewer2Image =
      'https://i.insider.com/5f8f4563dace450018a3e49d?width=1000&format=jpeg&auto=webp';
  String reviewer2Name = 'Ron Weasley';
  String review2Date = '1 March 1980';
  String review2 = 'Why Spiders?';
  double review2Rating = 4;
  String reviewer3Image =
      'https://i.insider.com/64395d57f62706001943009e?width=1200&format=jpeg';
  String reviewer3Name = 'Hermione Granger';
  String review3Date = '19 September 1979';
  String review3 = 'Books!';
  double review3Rating = 5;

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
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        builder: (BuildContext context) {
                          return const Wrap(children: [
                            EditPlaysBottomSheet(
                              sportsLogo: Icons.sports,
                              sportsName: 'Badminton',
                              level: 'Intermediate',
                              enabled: true,
                            )
                          ]);
                        });
                  },
                ),
                const SizedBox(height: 8),
                AboutCard(
                    text: userAbout,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          constraints:
                              const BoxConstraints(minWidth: double.infinity),
                          builder: (BuildContext context) {
                            return Wrap(children: [
                              EditAboutBottomSheet(
                                about: userAbout,
                              )
                            ]);
                          });
                    }),
                const SizedBox(height: 8),
                ProfessionCard(
                    text: userProfession,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          constraints:
                              const BoxConstraints(minWidth: double.infinity),
                          builder: (BuildContext context) {
                            return Wrap(children: [
                              EditProfessionBottomSheet(
                                profession: userProfession,
                              )
                            ]);
                          });
                    }),
                const SizedBox(height: 32),
                const TitleText(text: 'Games Stats'),
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
                const TitleText(text: 'Social Media'),
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
                const TitleText(text: 'Reviews and Ratings'),
                const SizedBox(height: 16),
                ReviewCard(
                  name: reviewer1Name,
                  image: reviewer1Image,
                  date: review1Date,
                  review: review1,
                  rating: review1Rating,
                ),
                const SizedBox(height: 8),
                ReviewCard(
                  name: reviewer2Name,
                  image: reviewer2Image,
                  date: review2Date,
                  review: review2,
                  rating: review2Rating,
                ),
                const SizedBox(height: 8),
                ReviewCard(
                  name: reviewer3Name,
                  image: reviewer3Image,
                  date: review3Date,
                  review: review3,
                  rating: review3Rating,
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ));
  }
}
