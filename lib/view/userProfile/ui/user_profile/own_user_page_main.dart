import 'package:flutter/material.dart';
import 'package:gear_up/view/chat/schedule_match_bottom_sheet.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/app_bar.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/details_card.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/plays_card.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/posh_card.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/profession_card.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/ratings_card.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/review_card.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/rewards_card.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/social_handle_card.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/stats_card.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/subscription_card.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/title_text.dart';
import 'package:gear_up/view/userProfile/viewmodel/my_profile_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../../data/response/api_response.dart';
import '../../../../data/response/status.dart';
import '../../model/player_profile_response.dart';
import 'about_card.dart';
import 'edit_about_bottom_sheet.dart';
import 'edit_play_bottom_sheet.dart';
import 'edit_profession_bottom_sheet.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MyProfileViewModel>(context);
    if (model.myProfileReponse.status == Status.IDLE) {
      model.fetchPlayerProfile(context);
      return const Center(child: CircularProgressIndicator());
    } else if (model.myProfileReponse.status == Status.LOADING) {
      return const Center(child: CircularProgressIndicator());
    } else if (model.myProfileReponse.status == Status.ERROR) {
      return errorUI(model);
    } else if (model.myProfileReponse.status == Status.COMPLETED) {
      return ui(context, model);
    } else {
      return errorUI(model);
    }
  }

  Scaffold ui(BuildContext context, MyProfileViewModel model) {
    return Scaffold(
        appBar: userProfileAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 48, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserDetailsCard(
                  userImage: model.myProfileReponse.data?.user?.img,
                  userName: model.myProfileReponse.data?.user?.name,
                  userAge: model.myProfileReponse.data?.user?.age,
                  userGender: model.myProfileReponse.data?.user?.gender,
                  userLocation:
                      model.myProfileReponse.data?.user?.currentAddress?.name,
                ),
                RatingCard(
                    userRating: model.myProfileReponse.data?.user?.rating),
                const SizedBox(height: 8),
                PlaysCard(
                  sportslist: model.myProfileReponse.data?.user?.favoriteSports,
                  onTap: () {
                    showModalBottomSheet(
                      useRootNavigator: true,
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      constraints:
                          const BoxConstraints(minWidth: double.infinity),
                      builder: (BuildContext context) {
                        return Wrap(children: [
                          EditPlaysBottomSheet(
                            favouriteSports: model.myProfileReponse.data?.user
                                    ?.favoriteSports ??
                                <FavoriteSport>[],
                          )
                        ]);
                      },
                    );
                  },
                  editable: true,
                ),
                const SizedBox(height: 8),
                AboutCard(
                  text: model.myProfileReponse.data?.user?.bio,
                  onTap: () {
                    showModalBottomSheet(
                        useRootNavigator: true,
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        builder: (BuildContext context) {
                          return Wrap(children: [
                            EditAboutBottomSheet(
                              about: model.myProfileReponse.data?.user?.bio,
                            )
                          ]);
                        });
                  },
                  editable: true,
                ),
                const SizedBox(height: 8),
                ProfessionCard(
                  text: model.myProfileReponse.data?.user?.profession,
                  onTap: () {
                    showModalBottomSheet(
                        useRootNavigator: true,
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        builder: (BuildContext context) {
                          return Wrap(children: [
                            EditProfessionBottomSheet(
                              profession:
                                  model.myProfileReponse.data?.user?.profession,
                            )
                          ]);
                        });
                  },
                  editable: true,
                ),
                const SizedBox(height: 32),
                const TitleText(text: 'Rewards & Subscription'),
                const SizedBox(height: 16),
                RewardsCard(bucks: model.myProfileReponse.data?.user?.bucks),
                const SizedBox(height: 8),
                const SubscriptionCard(),
                const SizedBox(height: 32),
                const TitleText(text: 'Posh Training'),
                const SizedBox(height: 16),
                const PoshCard(),
                const SizedBox(height: 32),
                const TitleText(text: 'Games Stats'),
                const SizedBox(height: 16),
                SizedBox(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        model.myProfileReponse.data?.user?.gameStats?.length ??
                            0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ExpandedTile(
                        gameStat: model.myProfileReponse.data?.user
                                ?.gameStats?[index] ??
                            GameStat(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
                const TitleText(text: 'Social Media'),
                const SizedBox(height: 16),
                SocialMediaCard(
                    text: 'Facebook',
                    icon: Icons.facebook,
                    isEditable: true,
                    link: model
                        .myProfileReponse.data?.user?.socialMedia?.facebook),
                const SizedBox(height: 8),
                SocialMediaCard(
                    text: 'Instagram',
                    icon: Icons.facebook,
                    isEditable: true,
                    link: model
                        .myProfileReponse.data?.user?.socialMedia?.instagram),
                const SizedBox(height: 8),
                SocialMediaCard(
                    text: 'Linkedin',
                    icon: Icons.facebook,
                    isEditable: true,
                    link: model
                        .myProfileReponse.data?.user?.socialMedia?.linkedin),
                const SizedBox(height: 8),
                SocialMediaCard(
                    text: 'X(Twitter)',
                    icon: Icons.facebook,
                    isEditable: true,
                    link: model
                        .myProfileReponse.data?.user?.socialMedia?.twitter),
                const SizedBox(height: 8),
                const SizedBox(height: 32),
                reviewsAndRatingsWidget(model),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ));
  }

  Widget reviewsAndRatingsWidget(MyProfileViewModel model) {
    final ratings = model.myProfileReponse.data?.user?.ratings;
    if (ratings == null || ratings.isEmpty) {
      return Container();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleText(text: 'Reviews and Ratings'),
          const SizedBox(height: 16),
          SizedBox(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  model.myProfileReponse.data?.user?.ratings?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ReviewCard(
                  rating: model.myProfileReponse.data?.user?.ratings?[index] ??
                      Rating(),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  Widget errorUI(MyProfileViewModel model) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Couldn't fetch your profile, kindly retry",
              style: TextStyle(
                color: Color(0xFFAFAFAF),
                fontSize: 16,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                model.myProfileReponse = ApiResponse.idle();
                model.notifyListeners();
              },
              child: const Icon(
                Icons.refresh,
                size: 32,
                color: Color(0xFFAFAFAF),
              ),
            )
          ],
        ),
      ),
    );
  }
}
